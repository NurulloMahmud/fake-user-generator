"""Fake User Generator - FastAPI Application."""
from fastapi import FastAPI, Request, Query
from fastapi.responses import HTMLResponse, JSONResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
import random
import os

from database import get_locales, generate_users, generate_users_json, run_benchmark

app = FastAPI(
    title="Fake User Generator",
    description="Generate random fake user data using SQL stored procedures",
    version="1.0.0"
)

# Setup templates
templates = Jinja2Templates(directory=os.path.join(os.path.dirname(__file__), "templates"))

@app.get("/", response_class=HTMLResponse)
async def home(request: Request):
    """Render the main page."""
    locales = get_locales()
    # Generate a random default seed
    default_seed = random.randint(1, 999999)
    return templates.TemplateResponse("index.html", {
        "request": request,
        "locales": locales,
        "default_seed": default_seed
    })

@app.get("/api/generate")
async def api_generate(
    seed: int = Query(..., description="Seed for reproducible generation"),
    batch: int = Query(0, ge=0, description="Batch index (0-based)"),
    count: int = Query(10, ge=1, le=100, description="Number of users to generate"),
    locale: str = Query("en_US", description="Locale code (en_US or de_DE)")
):
    """Generate fake users and return as JSON."""
    try:
        users = generate_users_json(seed, batch, count, locale)
        return JSONResponse(content={
            "success": True,
            "seed": seed,
            "batch": batch,
            "count": count,
            "locale": locale,
            "users": users
        })
    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={"success": False, "error": str(e)}
        )

@app.get("/api/locales")
async def api_locales():
    """Get available locales."""
    locales = get_locales()
    return JSONResponse(content={"locales": locales})

@app.get("/api/benchmark")
async def api_benchmark(
    count: int = Query(1000, ge=100, le=100000, description="Number of users to generate"),
    locale: str = Query("en_US", description="Locale code")
):
    """Run benchmark and return performance metrics."""
    try:
        result = run_benchmark(count, locale)
        return JSONResponse(content={
            "success": True,
            "benchmark": result
        })
    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={"success": False, "error": str(e)}
        )

@app.get("/health")
async def health():
    """Health check endpoint."""
    return {"status": "healthy"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)