import pymysql.cursors
from parse import parse
import sys
from datetime import datetime
import os
import socket

f = open('measure.txt', 'r')

try:
    conn = pymysql.connect(host='18.223.188.145', port=3306, user='skydustuser', password='skydust123!@#', db='finedustdb', charset='utf8')

except Exception:
    print("Error in MySQL connection")
else:
    for row in f:
        result = parse("Date: {}, PM2.5: {}, PM10: {}", row)
        query = "insert into finedust values ('"+str(result[0])+"', "+str(1)+", "+str(result[1])+", "+str(result[2])+");"
        cur = conn.cursor()
        cur.execute(query)
        conn.commit()

    conn.close()
    f.close()
    now = datetime.now()
    comm = 'mv measure.txt /home/skydust/recentdata/measure_'+str(now.year)+str(now.month)+str(now.day)+str(now.hour)+str(now.minute)+str(now.second)+'.txt'
    os.system(comm)
    f = open('measure.txt', 'w')
f.close()
