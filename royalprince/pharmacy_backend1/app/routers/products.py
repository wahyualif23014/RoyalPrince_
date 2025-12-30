# app/routers/products.py
from fastapi import APIRouter, HTTPException, Depends, Query
from typing import List, Optional
from app.models.product import PharmacyProduct, PHARMACY_PRODUCTS_DATA

router = APIRouter(prefix="/api/v1/products", tags=["products"])

@router.get("/", response_model=List[PharmacyProduct])
async def get_products(
    category: Optional[str] = Query(None, description="Filter by category"),
    featured: Optional[bool] = Query(None, description="Filter featured products"),
    min_price: Optional[float] = Query(None, ge=0, description="Minimum price"),
    max_price: Optional[float] = Query(None, ge=0, description="Maximum price"),
    limit: int = Query(20, ge=1, le=100, description="Limit results"),
    offset: int = Query(0, ge=0, description="Offset for pagination")
):
    """
    Get all pharmacy products with optional filters
    """
    filtered_products = PHARMACY_PRODUCTS_DATA
    
    # Apply filters
    if category:
        filtered_products = [p for p in filtered_products if p["category"] == category]
    
    if featured is not None:
        filtered_products = [p for p in filtered_products if p["isFeatured"] == featured]
    
    if min_price is not None:
        filtered_products = [p for p in filtered_products if p["price"] >= min_price]
    
    if max_price is not None:
        filtered_products = [p for p in filtered_products if p["price"] <= max_price]
    
    # Pagination
    start = offset
    end = offset + limit
    paginated_products = filtered_products[start:end]
    
    return paginated_products

@router.get("/{product_id}", response_model=PharmacyProduct)
async def get_product(product_id: str):
    """
    Get a single product by ID
    """
    for product in PHARMACY_PRODUCTS_DATA:
        if product["id"] == product_id:
            return product
    
    raise HTTPException(status_code=404, detail="Product not found")

@router.get("/categories/list", response_model=List[str])
async def get_categories():
    """
    Get all unique categories
    """
    categories = set()
    for product in PHARMACY_PRODUCTS_DATA:
        categories.add(product["category"])
    
    return sorted(list(categories))