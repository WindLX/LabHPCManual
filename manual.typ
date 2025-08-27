// Typst手册框架

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

#codly(
  languages: (
    rust: (name: "Rust", icon: "🦀", color: rgb("#CE412B")),
  ),
)

// 中文字体
#show emph: text.with(font: ("Libre Baskerville", "FZKai-Z03S"))


// 设置文档的基本属性
#set document(
  title: "飞行动力学控制与仿真实验室HPC使用手册",
  author: "汪宇航",
  keywords: ("HPC", "高性能计算", "手册", "使用指南"),
  date: auto,
)

// 设置页面格式
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2cm),
  header: context {
    if counter(page).get().first() > 1 [
      #set text(9pt)
      #grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [飞行动力学控制与仿真实验室HPC使用手册], [第 #counter(page).display() 页],
      )
      #line(length: 100%, stroke: 0.5pt)
    ]
  },
  footer: context {
    if counter(page).get().first() > 1 [
      #set text(9pt)
      #set align(center)
      #line(length: 100%, stroke: 0.5pt)
      #v(0.5em)
      [© 2025 飞行动力学控制与仿真实验室HPC使用手册. 保留所有权利.]
    ]
  },
)

// 设置文本格式
#set smartquote(enabled: true)
#set text(
  size: 12pt,
  lang: "zh",
  region: "cn",
  font: ("Libre Baskerville", "FZShuSong-Z01S"),
)

// 设置段落格式
#set par(first-line-indent: 2em)
#let indent = h(2em)

// 设置标题格式
#set heading(numbering: "1.1")
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(2em)
  set text(size: 20pt, weight: "bold", font: "FZHei-B01S")
  set align(center)
  it
  v(1em)
}
#show heading.where(level: 2): it => {
  v(1.5em)
  set text(size: 16pt, weight: "bold", font: "FZHei-B01S")
  it
  v(0.5em)
}
#show heading.where(level: 3): it => {
  v(1em)
  set text(size: 14pt, weight: "bold", font: "FZHei-B01S")
  it
  v(0.3em)
}

// 设置链接样式
#show link: set text(fill: blue)

// 设置代码块样式
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)


// ========================================
// 封面页
// ========================================
#set page(header: none, footer: none)

#align(center)[
  #v(3cm)

  #text(size: 32pt, weight: "bold", font: "FZHei-B01S")[
    飞行器动力学控制与仿真实验室高性能计算平台
  ]

  #v(1cm)

  #text(size: 28pt, weight: "bold")[
    使用手册
  ]

  #v(1cm)

  #text(size: 22pt)[
    HPC Manual
  ]

  #v(3cm)

  // 如果有实验室logo，请取消下面一行的注释并替换为正确的路径
  // #image("logo.png", width: 3cm)

  #v(2cm)

  #text(size: 18pt)[
    汪宇航 编写
  ]

  #v(1cm)

  #text(size: 16pt)[
    #datetime.today().display("[year]年[month]月[day]日")
  ]

  #v(1cm)

  #text(size: 14pt)[_版本 1.0_]
]

#pagebreak()

// ========================================
// 目录页
// ========================================
#set page(header: none, footer: none)

#align(center)[
  #text(size: 24pt, font: "FZHei-B01S")[目录]
]

#v(1cm)

#outline(
  title: none,
  depth: 3,
  indent: auto,
)

#pagebreak()

// ========================================
// 正文开始 - 从这里开始有页眉页尾
// ========================================
#set page(
  header: context {
    set text(9pt)
    grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [飞行动力学控制与仿真实验室 HPC 使用手册], [第 #counter(page).display() 页],
    )
    line(length: 100%, stroke: 0.5pt)
  },
  footer: context {
    set text(9pt)
    set align(center)
    line(length: 100%, stroke: 0.5pt)
    v(0.5em)
    [© 2025 飞行动力学控制与仿真实验室. 保留所有权利.]
  },
)

// 重置页码计数器
#counter(page).update(1)

// ========================================
// 前言
// ========================================
= 前言

欢迎使用我们的高性能计算平台！本手册将指导您快速上手并高效使用我们的计算资源。

为了帮助您快速、高效地利用我们强大的计算资源，请仔细阅读本手册。本平台旨在为您提供稳定、公平的计算环境，以加速您的科研进程。

== 核心设计原则

- *稳定压倒一切*: 生产力工具的基石；
- *物尽其用*：在资源受限的情况下，最大化硬件效能；
- *职责分离*: 容器化设计；
- *安全第一*: 最小化权限，默认拒绝，层层加固；
- *环境一致性与可复现性*：软件环境中心化，计算结果可复现；
- *用户体验*: 在管控与灵活之间寻求最佳平衡。

== 使用须知

在开始使用之前，请注意以下几点：

- 请遵守实验室的使用规范；
- 合理使用计算资源，避免浪费；
- 定期备份重要数据；
- 如遇问题，请及时联系管理员。

= 快速开始

本章将帮助您快速连接到服务器并开始使用。

== 系统架构

我们的计算平台由两台核心服务器组成：

- `ipc` (IP: `192.168.5.45:4000`): *登录节点*，集群的唯一入口
- `rs1` (IP: `192.168.5.36`): *计算节点*，负责运行计算任务

== 连接工具

我们强烈推荐使用 *VS Code* 及其 *Remote - SSH* 扩展作为您与服务器交互的工具。

= 环境配置

本章介绍如何配置您的工作环境。

== 基本环境设置

详细的环境配置步骤...

```bash
passwd
```


== 软件安装

如何安装所需的软件包...

= 作业管理

本章介绍如何提交和管理计算作业。

== Slurm作业调度系统

Slurm的基本使用方法...

== 作业提交

如何编写和提交作业脚本...

= 常见问题

本章收录了用户常遇到的问题及解决方案。

== 连接问题

网络连接相关的问题...

== 性能优化

如何优化您的计算任务...

= 附录

== 常用命令参考

常用Linux和Slurm命令的快速参考...

== 联系方式

管理员联系信息和技术支持渠道...
