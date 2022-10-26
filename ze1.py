#!/usr/bin/python3
# Filename: ze1.py
a=3

def local_f():
    a=8
    print(f'local_f={a}')
    
if __name__=="__main__":
    print("程序自身运行")
else:
    print("被另一个程序引用")


def pri( par ):
    print ("Hello ：: ",par)
    return


print(__name__)

