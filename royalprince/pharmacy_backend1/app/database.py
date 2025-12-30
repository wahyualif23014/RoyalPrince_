from datetime import datetime, timedelta
import random
from typing import List, Optional
from app.models.product import PharmacyProduct

# Database in-memory
products_db: List[PharmacyProduct] = []

def init_dummy_products(count: int = 50):
    global products_db
    
    categories = [
        'Analgesik & Antiinflamasi',
        'Antibiotik', 
        'Vitamin & Suplemen',
        'Obat Jantung',
        'Obat Diabetes',
        'Obat Pernafasan',
        'Obat Kulit',
        'Obat Mata',
        'Alat Kesehatan',
        'Herbal',
    ]
    
    manufacturers = [
        'Kalbe Farma', 'Kimia Farma', 'Dexa Medica',
        'Sanbe Farma', 'Phapros', 'Soho Global Health'
    ]
    
    for i in range(count):
        category = random.choice(categories)
        product = PharmacyProduct(
            id=f"prod_{i:03d}",
            name=_generate_name(category),
            description=_generate_description(category),
            category=category,
            price=random.choice([5000, 15000, 25000, 50000, 75000]),
            imageUrl=f"https://via.placeholder.com/300x200/2C3E50/FFFFFF?text=Product+{i}",
            rating=round(random.uniform(3.5, 5.0), 1),
            reviewCount=random.randint(10, 200),
            isPrescription=random.choice([True, False, False]),
            tags=_generate_tags(category),
            stock=random.randint(0, 200),
            manufacturer=random.choice(manufacturers),
            dosage=_generate_dosage(category),
            expiryDate=datetime.now() + timedelta(days=random.randint(30, 730)),
            isFeatured=random.choice([True, False, False, False])
        )
        products_db.append(product)

def _generate_name(category: str) -> str:
    names = {
        'Analgesik & Antiinflamasi': ['Paracetamol 500mg', 'Ibuprofen 400mg', 'Aspirin 80mg'],
        'Antibiotik': ['Amoxicillin 500mg', 'Metronidazole 500mg'],
        'Vitamin & Suplemen': ['Vitamin C 1000mg', 'Vitamin D3 4000IU'],
    }
    return random.choice(names.get(category, ['Obat Farmasi']))

def _generate_description(category: str) -> str:
    descriptions = {
        'Analgesik & Antiinflamasi': 'Obat pereda nyeri dan anti inflamasi',
        'Antibiotik': 'Obat untuk mengatasi infeksi bakteri',
        'Vitamin & Suplemen': 'Suplemen untuk menjaga daya tahan tubuh',
    }
    return descriptions.get(category, 'Obat untuk menjaga kesehatan')

def _generate_tags(category: str) -> List[str]:
    tag_map = {
        'Analgesik & Antiinflamasi': ['Pereda Nyeri', 'Anti Demam'],
        'Antibiotik': ['Infeksi', 'Resep Dokter'],
        'Vitamin & Suplemen': ['Daya Tahan', 'Nutrisi'],
    }
    return tag_map.get(category, ['Obat'])

def _generate_dosage(category: str) -> str:
    dosages = {
        'Analgesik & Antiinflamasi': '1 tablet setiap 4-6 jam',
        'Antibiotik': '1 tablet 3x sehari',
        'Vitamin & Suplemen': '1 tablet sehari',
    }
    return dosages.get(category, 'Sesuai petunjuk dokter')

# Initialize dummy data
init_dummy_products()