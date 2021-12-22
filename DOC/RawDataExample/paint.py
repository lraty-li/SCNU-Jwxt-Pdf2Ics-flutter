import json
from typing import Counter
import matplotlib
import matplotlib.pyplot as plt

#设置字体为楷体
matplotlib.rcParams['font.sans-serif'] = ['KaiTi']


def load(path):
    with open(path,'r',encoding="utf-8") as f:
        data = json.load(f)
        return data


    # store(data)

data = load("./ClassfiedPoints.json")
texts = load("./lessionText.json")


fig1 = plt.figure()
ax1 = fig1.add_subplot()


#patin lines
index =0 

while index<288:
    x0=data[index]['x'] # 右上角
    y0=data[index]['y']

    index+=1

    x1=data[index]['x'] # 右下角
    y1=data[index]['y']
    
    index+=1

    x2=data[index]['x'] # 左下角
    y2=data[index]['y']
    
    index+=1
    
    x3=data[index]['x']
    y3=data[index]['y']

    # print(x2,y2)
    # print(x0,y0)
    # print("====")
    rect=plt.Rectangle(
            (x2, y2),  # (x,y)矩形左下角
            x0-x2,  # width长
            y0-y2,  # height宽
            color='red', 
            fill=False,
            alpha=0.5)
    ax1.add_patch(rect)
    index+=1

# #pain texts
for item in texts:
    # print(item)
    ax1.text(float(item["x"]),float(item["y"]),item['str'])

plt.xlim(15, 1000)
plt.ylim(15, 1000)
plt.gca().set_aspect(1)
plt.show()
# plt.savefig("1.png")
