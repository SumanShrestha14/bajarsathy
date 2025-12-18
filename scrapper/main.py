import requests
from bs4 import BeautifulSoup

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
                "name": cols[0].get_text(strip=True),
                "unit": cols[1].get_text(strip=True),
                "min_price": cols[2].get_text(strip=True),
                "max_price": cols[3].get_text(strip=True),
                "avg_price": cols[4].get_text(strip=True),
            })

    return market_data


# Run it
prices = scrape_kalimati()
length = len(prices)
for p in prices[:length]:
    print(f"{p['name']}: Rs. {p['avg_price']}")
