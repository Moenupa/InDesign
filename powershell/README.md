# PowerShell

## 目录 Contents

> 🔴 [字体，字体大小和颜色 | Fonts, Size and Colors](https://github.com/Moenupa/InDesign/tree/master/powershell#%E5%AD%97%E4%BD%93%E5%AD%97%E4%BD%93%E5%A4%A7%E5%B0%8F%E5%92%8C%E9%A2%9C%E8%89%B2--fonts-size-and-colors)
>> 🟠 [字体 | Fonts](https://github.com/Moenupa/InDesign/tree/master/powershell#%E5%AD%97%E4%BD%93--fonts)  
>> 🟡 [大小 | Size](https://github.com/Moenupa/InDesign/tree/master/powershell#%E5%A4%A7%E5%B0%8F--size)  
>> 🟢 [颜色 | Color](https://github.com/Moenupa/InDesign/tree/master/powershell#%E9%A2%9C%E8%89%B2--color)  
> 🟣 [oh-my-posh 及其自定义 | Powershell Beautifying by oh-my-posh and Personalization](https://github.com/Moenupa/InDesign/tree/master/powershell#oh-my-posh-%E5%8F%8A%E5%85%B6%E8%87%AA%E5%AE%9A%E4%B9%89--powershell-beautifying-by-oh-my-posh-and-personalization)  
> 🔵

## 字体，字体大小和颜色 | Fonts, Size and Colors

> 设置方法 Set-Up Method:  
>> Powershell - 属性/默认值 - 字体  
>> PowerShell - Settings - Fonts

### 字体 | Fonts

常用的有以下几种（优先度由高到低）Common Fonts (Highly-to-Poorly Recommended)

灰色字符代表无法显示。 Grey characters represent non-supports.

- [Sarasa Mono](https://github.com/be5invis/Sarasa-Gothic) [<sup>ⓘ</sup>](TODO:)

![特点：支持UTF32 Feature: UTF32 Support](https://github.com/Moenupa/InDesign/blob/master/src/fonts/sarasa_mono.png)

- [Fira Code](https://github.com/tonsky/FiraCode) [<sup>ⓘ</sup>](TODO:)

![特点：合字 Feature: Ligature](https://github.com/Moenupa/InDesign/blob/master/src/fonts/fira_code.png)

- [Source Code Pro](https://github.com/adobe-fonts/source-code-pro) [<sup>ⓘ</sup>](TODO:)

![特点：圆滑整洁 Feature: Tidy](https://github.com/Moenupa/InDesign/blob/master/src/fonts/source_code_pro.png)

- Consolas

![特点：美观且普适 Feature: Clean and Widespread](https://github.com/Moenupa/InDesign/blob/master/src/fonts/consolas.png)

- Courier New

![特点：万物可用 Feature: Universal](https://github.com/Moenupa/InDesign/blob/master/src/fonts/courier_new.png)

其中 **Sarasa Mono T TC** 为**主选字体**，其他均为备选字体。因为在 PowerShell 美化过程中或牵涉到 UTF32 字符。在美化中发现 ⍰ （字符无法显示） 的感觉可不好。

Among them, the **Sarasa Mono T TC** font is considered as **primary**, the rest are all back-ups. It is because while beautifying PowerShell, UTF32 characters are involved. It is not a good idea to have ⍰ (character cannot be displayed) while working.

此处的字体推荐和分析不完全适用于所有终端。以上的字体均为**等距字体**，在计算机行业中意义较大。若有其他用途请转至[衬线、非衬线还是等宽？](TODO:)

The font recommendation and analysis can is valuable to all terminal configuration with few exceptions. The above fonts are **mono-spaced** fonts, which is usually implemented in the computing industry. For other uses please got to [Sans, Sans Serif or Mono?](TODO:)

### 大小 | Size

TODO:

### 颜色 | Color

TODO:

## oh-my-posh 及其自定义 | Powershell Beautifying by oh-my-posh and Personalization

在 PowerShell 以管理员执行以下代码： | Run the following commands using PowerShell (run as admin)

```powershell

Set-ExecutionPolicy RemoteSigned   # 解除限制

Install-Module posh-git            # 安装 posh-git
Install-Module oh-my-posh          # 安装 oh-my-posh

notepad $PROFILE                   # 用记事本修改 $PROFILE 文件   edit $PROFILE

```

> In the *$PROFILE* file:  
> Import-Module posh-git  
> Import-Module ph-my-posh  
> Set-Theme OneMore

原链接 Original link: [oh-my-posh on Github](https://github.com/JanDeDobbeleer/oh-my-posh)
