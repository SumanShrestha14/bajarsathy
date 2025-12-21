import sys
import requests
from bs4 import BeautifulSoup

sys.stdout.reconfigure(encoding='utf-8')

API_URL = "https://sumanshrestha14.com.np/api/prices"


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
            market_data.append({
                "product_name": cols[0].get_text(strip=True),
                "unit": cols[1].get_text(strip=True),
                "min_price": cols[2].get_text(strip=True),
                "max_price": cols[3].get_text(strip=True),
                "avg_price": cols[4].get_text(strip=True),
            })

    return market_data

def send_to_laravel(data):
    headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-API-KEY": "kalimati_secret_123"
    }

    response = requests.post(API_URL, json=data, headers=headers)

    if response.status_code in [200, 201]:
        print(f"Stored: {data['product_name']}")
    else:
        print(f"Failed to store {data['product_name']}", response.text)


# Run it
prices = scrape_kalimati()
length = len(prices)
for p in prices[:length]:
    print(f"{p['product_name']}: Rs. {p['avg_price']}:: Rs. {p['avg_price']}:: Rs. {p['max_price']}:: Rs. {p['min_price']}")
    send_to_laravel(p)
