client_seeds = [
  ["Anthony", "Moffa", "20 Madison Street, Apt. 3", "20 Madison Street, Somerville, MA 02143", "Somerville", "MA", "02143", 0],
  ["Zachary", "Markin", "24 Marion Road", "24 Marion Road, Belmont, MA 01478" "Belmont", "MA", "01478", 0],
  ["Lillian", "Smith", "2549 North Road", "2549 North Road, Blue Mounds, WI 21745", "Blue Mounds", "WI", "21745", 0],
  ["Steven", "Ramirez", "5 West Street", "9 Rollins Court, Cambridge, MA 02139", "Everett", "MA", "02149", 0],
  ["Sarah", "LeBlanc", "10 Windsor Street", "100 Great Rd, Littleton, MA 01460", "Cambridge","MA", "02139", 0],
  ["Aurelio", "Moffa", "27 Bryant Street", "1647 Northshore Road, Revere, MA 02151", "Revere", "MA", 0],
  ["Shelbi", "Ferber" "24 Armington Street", "24 Armington Street, Boston, MA 02134", "Boston", "MA", 0]
]

services_seeds = [
  "Cut",
  "Sprinkler Installation",
  "Bushes",
  "Mulch",
  "Sod"
]

client_price_seeds = [
  ["Cut", 150, 1],
  ["Bushes", 200, 1],
  [services_seeds.sample, 125, 2],
  [services_seeds.sample, 300, 3],
  [services_seeds.sample, 200, 3],
  [services_seeds.sample, 130, 4],
  [services_seeds.sample, 80, 5],
  [services_seeds.sample, 275, 5],
  [services_seeds.sample, 60, 6],
  [services_seeds.sample, 175, 6],
  [services_seeds.sample, 150, 7],
  [services_seeds.sample, 225, 8],
  [services_seeds.sample, 150, 8],
  ]

invoice_seeds = [
  [Date.today, "Anthony", "PENDING", "Call to discuss estimate for porch", 0, 1],
  [Date.today-1, "Anthony", "PENDING", "", 0, 2],
  [Date.today-1, "Anthony", "PENDING", "", 0, 3],
  [Date.today, "Anthony", "PENDING", "", 0, 4],
  [Date.today, "Anthony", "PENDING", "Don't cut next week", 0, 5],
  [Date.today-2, "Anthony", "PENDING", "", 0, 6],
  [Date.today, "Anthony", "PENDING", "", 0, 7],
  [Date.today-2, "Aurelio", "PENDING", "Check perennials", 0, 1],
  [Date.today-2, "Aurelio", "PENDING", "", 0, 3]
]

client_seeds.each do |first, last, addr, job_addr, city, state, zip, balance|
  Client.create(first_name: first, last_name: last, billing_address: addr, job_address: job_addr, city: city, state: state, zip: zip, balance: balance)
end

services_seeds.each do |name|
  Service.create(name: name)
end

client_price_seeds.each do |name, price, id|
  ClientPrice.create(name: name, price: price, client_id: id)
end

invoice_seeds.each do |date, performed, status, note, total, client_id|
  Invoice.create(date: date, performed_by: performed, status: status, note: note, total: total, client_id: client_id)
end