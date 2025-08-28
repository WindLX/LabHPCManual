// Typst手册框架

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

#codly(
  languages: (
    python: (name: "Python", icon: "🐍", color: rgb("#3572A5")),
    bash: (name: "Bash", icon: "🐚", color: rgb("#129a42")),
    rust: (name: "Rust", icon: "🦀", color: rgb("#CE412B")),
  ),
)

// 中文字体
#show strong: text.with(font: ("Libre Baskerville", "FZHei-B01S"))
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


== 版本历史


// ========================================
// 部分页
// ========================================
#set page(header: none, footer: none)

#align(center)[
  #v(8cm)

  #text(size: 32pt, weight: "bold", font: "FZHei-B01S")[
    第一部分：架构总览
  ]
]

= 平台拓扑与硬件清单

本章将帮助您快速连接到服务器并开始使用。

== 系统架构


== 硬件规格详单


== 软件栈概览 (OS, Slurm, NVIDIA, Docker, ... )


== 外部服务集成


=== EasyTier VPN: 实现安全的远程访问。


=== 独立NAS系统: 作为团队共享的数据仓库。



// ========================================
// 部分页
// ========================================
#set page(header: none, footer: none)

#align(center)[
  #v(8cm)

  #text(size: 32pt, weight: "bold", font: "FZHei-B01S")[
    第二部分：从零到集群——平台搭建实录 (管理员篇)
  ]
]


= 操作系统安装与基础加固

== Debian 13 "Trixie" 最小化服务器安装

=== 关键分区方案 (`/home`, `/var`, `/tmp`分离)

*   2.2 基础系统配置
    *   2.2.1 APT镜像源配置 (`main`, `non-free`)
    *   2.2.2 核心工具集与防火墙(UFW)配置
    *   2.2.3 **(修订)** 安全模型：`su`代替`sudo`
    *   2.2.4 中文与国际化支持 (Locale)
*   2.3 SSH服务安全加固 (`/etc/ssh/sshd_config`)
    *   2.3.1 禁用密码与root登录，强制使用SSH密钥。

*   **第三章：核心计算环境部署**
    *   3.1 NVIDIA GPU环境部署
        *   3.1.1 诊断与决策：从`backports`到`.run`安装包
        *   3.1.2 使用`.run`文件与DKMS及开源内核模块进行安装
        *   3.1.3 `nvidia-persistenced`服务的手动配置
        *   3.1.4 CUDA Toolkit与cuDNN的安装
    *   3.2 Slurm一体化部署
        *   3.2.1 Munge认证配置
        *   3.2.2 数据库(MariaDB)与`slurmdbd`记账配置
        *   3.2.3 `slurm.conf`最终版详解 (单节点，多角色)
        *   3.2.4 `gres.conf`与`cgroup.conf`的精确配置
        *   3.2.5 QOS与分区的精细化权限管理

*   **第四章：用户环境与软件栈**
    *   4.1 全局共享软件的安装 (`/opt`)
        *   4.1.1 Docker, Redis (通过`apt`)
        *   4.1.2 Rust, Node.js, Miniforge, uv (手动安装至`/opt`)
    *   4.2 全局环境变量配置 (`/etc/profile.d`)
    *   4.3 软件镜像源的统一配置
    *   4.4 预装科学计算库与命令行工具集

*   **第五章：用户会话的资源限制 (原生安全核心)**
    *   5.1 **PAM与cgroups v2的协同工作原理**
    *   5.2 **使用`systemd` Slice单元定义资源模板** (`/etc/systemd/system/user-.slice.d/`)
        *   5.2.1 限制CPU (`CPUQuota`, `CPUWeight`)
        *   5.2.2 限制内存 (`MemoryMax`)
        *   5.2.3 **【核心】通过设备白名单禁止GPU访问 (`DevicePolicy`, `DeviceAllow`)**
    *   5.3 (新增) **通过`/etc/fstab`限制进程可见性**
        *   5.3.1 `hidepid`挂载选项的原理与应用
        *   5.3.2 配置`/proc`的挂载，增强用户隔离
    *   5.4 (新增) **通过文件权限避免安全问题**
        *   5.4.1 锁定`/opt`共享软件目录为只读
        *   5.4.2 其他关键目录的权限策略



// ========================================
// 部分页
// ========================================
#set page(header: none, footer: none)

#align(center)[
  #v(8cm)

  #text(size: 32pt, weight: "bold", font: "FZHei-B01S")[
    第三部分：集群的日常——运维管理实战 (管理员篇)
  ]
]



// ========================================
// 部分页
// ========================================
#set page(header: none, footer: none)

#align(center)[
  #v(8cm)

  #text(size: 32pt, weight: "bold", font: "FZHei-B01S")[
    第四部分：开始计算！——科研平台使用指南 (用户篇)
  ]
]


---

// ========================================
// 部分页
// ========================================
#set page(header: none, footer: none)

#align(center)[
  #v(8cm)

  #text(size: 32pt, weight: "bold", font: "FZHei-B01S")[
    第五部分：NAS数据中心使用指南
  ]
]




= 附录

== 常用命令参考

常用Linux和Slurm命令的快速参考...

== 联系方式

管理员联系信息和技术支持渠道...
