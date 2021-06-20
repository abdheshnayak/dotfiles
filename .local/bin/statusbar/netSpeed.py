import time
import psutil
def main():
    old_value = 0    

    new_value = psutil.net_io_counters().bytes_sent + psutil.net_io_counters().bytes_recv
    send_stat(new_value)

def convert_to_gbit(value):
    return value/1024./1024./1024.*8

def convert_to_mbit(value):
    return value/1024./1024.*8

def convert_to_kbit(value):
    return value/1024.*1.5

def send_stat(value):
    try:
        f = open("speed.txt", "r")
        old_val=f.read()
    except IOError:
        old_val="0"
        pass

    new_val="%0.0f" % convert_to_kbit(value)
    f = open("speed.txt", "w")
    f.write(new_val)
    f.close()
    print ("%d KB" % (int(new_val)-int(old_val)))
main()
