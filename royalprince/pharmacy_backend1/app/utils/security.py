from fastapi import HTTPException, Security
from fastapi.security import APIKeyHeader
from dotenv import load_dotenv
import os

load_dotenv()

API_KEY_NAME = os.getenv("API_KEY_NAME", "X-API-Key")
API_KEY = os.getenv("API_KEY")

if not API_KEY:
    raise ValueError("API_KEY tidak ditemukan di environment variables")

api_key_header = APIKeyHeader(name=API_KEY_NAME, auto_error=False)

async def validate_api_key(api_key: str = Security(api_key_header)):
    if api_key != API_KEY:
        raise HTTPException(
            status_code=401,
            detail={
                "status": "error",
                "message": "Invalid API Key",
                "error_code": "UNAUTHORIZED"
            }
        )
    return api_key

def create_api_response(status: str, message: str, data=None, error_code=None):
    response = {
        "status": status,
        "message": message,
        "timestamp": datetime.now().isoformat(),
        "data": data or {}
    }
    if error_code:
        response["error_code"] = error_code
    return response