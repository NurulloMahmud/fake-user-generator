import os
import psycopg2
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv

load_dotenv()

def get_connection():
    return psycopg2.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        port=os.getenv('DB_PORT', '5432'),
        dbname=os.getenv('DB_NAME', 'fake_users'),
        user=os.getenv('DB_USER', ''),
        password=os.getenv('DB_PASSWORD', '')
    )

def get_locales():
    conn = get_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("SELECT * FROM faker_get_locales()")
            return cur.fetchall()
    finally:
        conn.close()

def generate_users(seed: int, batch: int, count: int, locale: str):
    conn = get_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(
                "SELECT * FROM faker_generate_users(%s, %s, %s, %s)",
                (seed, batch, count, locale)
            )
            return cur.fetchall()
    finally:
        conn.close()

def generate_users_json(seed: int, batch: int, count: int, locale: str):
    conn = get_connection()
    try:
        with conn.cursor() as cur:
            cur.execute(
                "SELECT faker_generate_users_json(%s, %s, %s, %s)",
                (seed, batch, count, locale)
            )
            result = cur.fetchone()
            return result[0] if result else []
    finally:
        conn.close()

def run_benchmark(count: int, locale: str):
    conn = get_connection()
    try:
        with conn.cursor() as cur:
            cur.execute(
                "SELECT faker_benchmark(%s, %s)",
                (count, locale)
            )
            result = cur.fetchone()
            return result[0] if result else {}
    finally:
        conn.close()