import csv
import pandas as pd

txt_file = r"newStats-singleCore-a15-mica-wps3a0.txt"
csv_file = r"toSheet-singleCore-a15-mica-wps3a0.csv"

in_txt = csv.reader(open(txt_file, "rb"), delimiter = ',')
# print(list(in_txt)[1:2])
out_csv = csv.writer(open(csv_file, 'wb'))

out_csv.writerows(list(in_txt)[0:300])

