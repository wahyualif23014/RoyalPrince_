from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv
import os
from app.routers import products

load_dotenv()

app = FastAPI(
    title="Pharmacy Product API",
    description="API untuk mengelola produk farmasi dengan otentikasi API Key",
    version="1.0.0",
    docs_url="/docs" if os.getenv("DEBUG") == "True" else None,
    redoc_url="/redoc" if os.getenv("DEBUG") == "True" else None
)

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Ubah ke domain spesifik di production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(products.router)

@app.get("/")
async def root():
    return {
        "status": "success",
        "message": "Pharmacy Product API is running",
        "version": "1.0.0",
        "docs": "/docs" if os.getenv("DEBUG") == "True" else None
    }

@app.get("/health")
async def health_check():
    return {"status": "healthy", "service": "pharmacy-api"}