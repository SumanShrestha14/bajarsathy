import sys
import requests
from bs4 import BeautifulSoup

sys.stdout.reconfigure(encoding='utf-8')

API_URL = "https://sumanshrestha14.com.np/api/prices"
API_KEY = "kalimati_secret_123"


def clean_price(price):
    """Remove non-digit characters and convert to number string"""
    return ''.join(filter(lambda x: x.isdigit(), price)) or "0"
API_KEY = "kalimati_secret_123"


def clean_price(price):
    """Remove non-digit characters and convert to number string"""
    return ''.join(filter(lambda x: x.isdigit(), price)) or "0"


def scrape_kalimati():
    url = "https://kalimatimarket.gov.np/price"
    headers = {"User-Agent": "Mozilla/5.0"}

    response = requests.get(url, headers=headers, timeout=10)
    if response.status_code != 200:
        print(f"Failed to fetch data. Status code: {response.status_code}")
        return []

    soup = BeautifulSoup(response.text, "html.parser")
    table = soup.find("table")
    if not table:
        print("Price table not found on page")
        return []

    rows = table.find_all("tr")
    market_data = []

    for row in rows[1:]:
        cols = row.find_all("td")
        if len(cols) >= 5:
            product = {
            product = {
                "product_name": cols[0].get_text(strip=True),
                "unit": cols[1].get_text(strip=True),
                "min_price": clean_price(cols[2].get_text(strip=True)),
                "max_price": clean_price(cols[3].get_text(strip=True)),
                "avg_price": clean_price(cols[4].get_text(strip=True)),
            }
            market_data.append(product)
                "min_price": clean_price(cols[2].get_text(strip=True)),
                "max_price": clean_price(cols[3].get_text(strip=True)),
                "avg_price": clean_price(cols[4].get_text(strip=True)),
            }
            market_data.append(product)

    return market_data


def send_to_laravel(products):

def send_to_laravel(products):
    headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-API-KEY": API_KEY
        "X-API-KEY": API_KEY
    }

    # Wrap all products in "products" array
    payload = {"products": products}

    response = requests.post(API_URL, json=payload, headers=headers)
    # Wrap all products in "products" array
    payload = {"products": products}

    response = requests.post(API_URL, json=payload, headers=headers)

    if response.status_code == 201:
        print(f"Successfully stored {len(products)} products")
    if response.status_code == 201:
        print(f"Successfully stored {len(products)} products")
    else:
        print(f"Failed to store products: {response.status_code}")
        print(response.text)
        print(f"Failed to store products: {response.status_code}")
        print(response.text)


# -----------------------------
# Run the script
# -----------------------------
# -----------------------------
# Run the script
# -----------------------------
prices = scrape_kalimati()

if not prices:
    print("No data scraped.")
else:
    # Optional: Print prices
    for p in prices:
        print(f"{p['product_name']}: Rs. {p['avg_price']} (min: {p['min_price']}, max: {p['max_price']})")

    # Send all products to Laravel API at once
    send_to_laravel(prices)