# scnu_jwxt_pdf2ics_flutter

将华南师范大学教务系统输出的pdf转为ics文件

[SCNU-Jwxt-Pdf2Ics]((https://github.com/lraty-li/SCNU-Jwxt-Pdf2Ics)) 的flutter版本。 [在线 demo](https://lraty-li.github.io/) （转换功能有bug）

目前仅支持Android设备（无IOS设备用于开发）。

***readme撰写中。***

## How to translate this app to your language?

1. Create arb file under `\lib\l10n`, naming it as ```app_[language code]_[script code]_[country code].arb```, you can simply copy one of these arb files then rename it.

2. Translated text stored in ```"key":"value"``` form in arb file. keep the 'key' ,translate the value to your language. The ```langSelfDescr``` means what language it is, and it's value would be displayed when user choosing language.

3. The program will do the rest.

- offical guide [here](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)  

## 如何适配IOS？

需要注意的有

- 实现提取pdf文本及其坐标

- 日志文件实现非常暴力

## 课表形式已经更改/如何适配其他学校？

- 由插件返回的文本`_pdfDoc.text` 是Json格式的字符串，解析后得到```{x:坐标值,y:坐标值,str:"单词"}```，单词的坐标为第一个字符的坐标，注意pdf中坐标轴方向的问题。

- [转换过程](https://github.com/lraty-li/SCNU-Jwxt-Pdf2Ics-flutter/blob/main/lib/Page/PdfLoadedPage.dart#L69)。

- 关于提取线（边框），`PdfParser.kt` 中注释了收集线路径的方法，懒得重写数据整理的代码而没有使用。需要注意该方法并没有对坐标进行变换，与目前导出的文本坐标将不一致。

- `DOC/RawDataExample`下有绘制示例，注意坐标轴延伸方向，相关个人信息已改为NULL。

- 参考 [PDFBox - Line / Rectangle extraction](https://stackoverflow.com/questions/55166990/pdfbox-line-rectangle-extraction) 与 [pdfbox 2.0.2 ....](https://stackoverflow.com/questions/38931422/pdfbox-2-0-2-calling-of-pagedrawer-processpage-method-caught-exceptions)

## 其他

- 日志功能是暴力地经由ffi调用dup2实现[地址](https://github.com/lraty-li/flutter_dup2)，第一次编译需要下载ndk，完成时间受网络状况影响。
- 本项目修改并直接使用了[flutter-pdf-text](https://github.com/AlessioLuciani/flutter-pdf-text)中的代码，由导出文本改为导出符号及其坐标。插件计划仅上传到GitHub。
