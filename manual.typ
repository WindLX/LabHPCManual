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

#import "@preview/zh-kit:0.1.0": *

#show: doc => setup-base-fonts(
  doc,
  first-line-indent: 2em,
)


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
// #show link: set text(fill: blue)

// 设置 footnote 样式
#show footnote: set text(size: 16pt)

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
#page(
  align(center)[
    #v(8cm)

    #text(size: 32pt, weight: "bold", font: "FZHei-B01S")[
      第一部分：架构总览
    ]
  ],
  header: none,
  footer: none,
)


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
#page(
  align(center)[
    #v(8cm)

    #text(size: 32pt, weight: "bold", font: "FZHei-B01S")[
      第二部分：从零到集群——平台搭建实录 (管理员篇)
    ]
  ],
  header: none,
  footer: none,
)


= 操作系统安装与基础加固

本章的目标是安装一个最小化、稳定且安全的 Debian 13 "Trixie"#footnote[Debian 13 恰好在笔者开始搭建此套系统的近期发布，参见新闻：https://www.debian.org/News/2025/20250809.] 操作系统，
并完成基础的系统配置，为后续所有的服务部署打下监视的基础。

== Debian 13 "Trixie" 最小化服务器安装

=== 为什么选择 Debian ?

Debian 是一个稳定、可靠且广泛使用的 Linux 发行版，适合用于服务器环境。它拥有强大的社区支持和丰富的软件包库，能够满足各种应用需求。其社区致力于提供一个纯粹的、无专有软件后门的开源系统，符合科研环境对透明度和安全性的要求。而且 Debian 拥有一个强大的、成熟的包管理器 `apt`，软件仓库虽不追求最新，但极其稳定和全面。

=== 最小化服务器安装流程

首先需要我们需要下载 Debian 13 "Trixie" 的网络安装镜像（Netinstall ISO）#footnote[国内网络环境可以选择去 Debian 的镜像网站下载镜像：https://www.debian.org/CD/http-ftp/#mirrors.]，然后使用该镜像制作一个启动U盘，接着从U盘启动并进行系统安装，有多种引导 U 盘程序可供选择，此处我们建议使用 Ventoy 设置 U 盘#footnote[简单来说，Ventoy是一个制作可启动U盘的开源工具。有了Ventoy你就无需反复地格式化U盘，你只需要把 ISO/WIM/IMG/VHD(x)/EFI 等类型的文件直接拷贝到U盘里面就可以启动了，无需其他操作：https://www.ventoy.net/cn/doc_start.html.]。

将 USB 启动盘插入服务器，在开机进入引导之前，连续按下 `F11` 或 `DELETE`（具体按键视主板而定）进入启动菜单，然后配置引导选项，找到安装 U 盘，并修改为第一位的引导选项。

重启系统，系统会从U盘启动，选择我们安装的 Debian 13 镜像，接着选择 `Install`，进入 Debian 13 的安装引导程序。

=== 分区方案

服务器的分区方案会和个人用户安装系统的分区方案有所不同，服务器更要求系统的稳定性和安全性，一个常见的方案是将系统、日志、用户数据和临时文件隔离开，防止单一分区写满导致整个系统崩溃。具体而言，此处我们使用的分区规划如下所示：

- 1 GB - EFI System Partition，挂载在 /boot/efi，引导分区。
- 100 GB - ext4文件系统, 挂载点 / ，根分区。
- 40 GB - ext4文件系统, 挂载点 /var ，日志分区。
- 3 GB - ext4文件系统, 挂载点 /tmp ，临时文件分区#footnote[对于为 NVIDIA DKMS 编译来说，这个分区大小并不够用，实际操作时会临时挂载 /home 分区借用给 /tmp 分区用以编译临时文件的存储。]。
- 101 GB - swap 交换空间，这个值通常与内存大小直接相关，由于服务器需要处理大量数据，建议分配较大空间。
- 1.6 T (剩余全部空间) - ext4文件系统, 挂载点 /home (用户数据分区)。

完成分区后，将修改写入磁盘。

服务器不需要安装桌面服务，在 “Software selection” 步骤，取消所有桌面环境 (如 GNOME, KDE等)，仅勾选以下两项：

- `[*] SSH server`：用以外部 SSH 远程登录；
- `[*] standard system utilities`：提供了一些常见的系统的组件。

接下来，安装程序会提示配置一个用户账户，在安装过程中设置一个强大的root密码，并创建一个您的个人管理员账户（例如`windlx`）。


=== 基础系统配置

当我们完成了操作系统安装后，拔掉 U 盘，重启电脑，即可进入 Debian 13 的 tty#footnote[在 Linux 和 UNIX 系统中，TTY 是“电传打字机”（TeleTypeWriter）的缩写，最初指的是一种通过串行线与计算机进行通信的设备。现在，TTY 通常指代终端设备，它是字符型设备，用于与操作系统进行交互。]。我们可以使用键盘和显示器直接操作服务器。接下来，我们将进行一系列基础配置，以确保系统的稳定性、安全性和可用性。

网络配置
静态IP： 登录系统后，编辑`/etc/network/interfaces`或使用`nmtui`为服务器设置一个固定的内网IP地址（例如`192.168.10.11`）。
主机名： `hostnamectl set-hostname rs1`
主机名解析 (`/etc/hosts`): 编辑`/etc/hosts`，确保`127.0.1.1`指向`rs1`，并添加其他集群节点（如`ipc`）的IP和主机名映射。

=== APT镜像源配置

限于国内网络环境，我们建议配置国内的 `apt` 镜像源以加速软件安装和更新。

```bash
# 备份原始文件
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# 编辑主源文件
vim /etc/apt/sources.list
```

写入以下内容：

```bash
#deb cdrom:[Debian GNU/Linux 13.0.0 _Trixie_ - Official amd64 NETINST with firmware 20250809-11:20]/ trixie contrib main non-free-firmware

deb http://mirrors.ustc.edu.cn/debian/ trixie main non-free-firmware contrib non-free
deb-src http://mirrors.ustc.edu.cn/debian/ trixie main non-free-firmware contrib non-free

deb http://security.debian.org/debian-security trixie-security main non-free-firmware contrib non-free
deb-src http://security.debian.org/debian-security trixie-security main non-free-firmware contrib non-free

# trixie-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
deb http://mirrors.ustc.edu.cn/debian/ trixie-updates main non-free-firmware contrib non-free
deb-src http://mirrors.ustc.edu.cn/debian/ trixie-updates main non-free-firmware contrib non-free

# This system was installed using removable media other than
# CD/DVD/BD (e.g. USB stick, SD card, ISO image file).
# The matching "deb cdrom" entries were disabled at the end
# of the installation process.
# For information about how to configure apt package sources,
# see the sources.list(5) manual.
```

```bash

apt update
```

=== 核心工具集与防火墙(UFW)配置

安装
```bash
apt upgrade -y
apt install -y build-essential curl wget git vim nano htop bmon ufw unzip dkms linux-headers-amd64
```

配置UFW：
```bash
# 允许SSH连接（这是您的生命线！）
ufw allow ssh

# 启用防火墙
ufw enable

# 检查状态
ufw status
```

=== 安全模型：`su`代替`sudo`

*   **哲学：** 本服务器不安装`sudo`。所有管理员操作必须通过`su -`命令，输入`root`密码，进入一个完整的`root` shell来执行。这强制区分了管理会话和普通用户会话，更加安全可控。
*   **操作：** 无需安装`sudo`包。

=== 国际化与中文支持 (Locale)

*   **目标：** 让终端能正确显示中文，同时保持系统日志为英文。
*   **操作：**
```bash
# 1. 安装字体和工具
apt install -y locales fonts-wqy-microhei fonts-noto-cjk

# 2. 配置Locales
dpkg-reconfigure locales
# -> 在界面中勾选 en_US.UTF-8 和 zh_CN.UTF-8
# -> 在下一个界面中，选择 en_US.UTF-8 作为系统默认

# 3. 创建全局环境配置文件，以启用中文字符类型
nano /etc/profile.d/98-locale-settings.sh
# 写入:
# export LANG=en_US.UTF-8
# export LC_CTYPE="zh_CN.UTF-8"

chmod +x /etc/profile.d/98-locale-settings.sh
```

== 2.3 SSH服务安全加固

**目标：** 将SSH服务从一个“敞开的大门”加固成一个“需要多重验证的保险库入口”。

*   **操作：** 编辑`/etc/ssh/sshd_config`文件，应用以下核心安全设置。
  ```bash
  # 备份
  cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

  # 编辑
  nano /etc/ssh/sshd_config
  ```
*   **关键修改项：**
*   `PermitRootLogin no`: **禁止root用户直接登录。**
*   `PasswordAuthentication no`: **禁用密码认证，强制使用SSH密钥。**
*   `PubkeyAuthentication yes`: 确保公钥认证开启。
*   `AllowGroups hpc_users hpc_admin`: **只允许**属于`hpc_users`和`hpc_admin`组的成员登录。
*   `MaxAuthTries 3`: 限制认证尝试次数。
*   `X11Forwarding no`: 关闭不必要的GUI转发功能。
*   **应用配置：*
```bash
# 语法检查，确保没有错误
sshd -t

# 重启服务
systemctl restart sshd
```

== 基础系统配置

=== APT镜像源配置 (`main`, `non-free`)

=== 核心工具集与防火墙(UFW)配置

=== 安全模型：`su`代替`sudo`

=== 中文与国际化支持 (Locale)

== SSH服务安全加固 (`/etc/ssh/sshd_config`)

=== 禁用密码与root登录，强制使用SSH密钥。


= 核心计算环境部署

== NVIDIA GPU环境部署

=== 诊断与决策：从`backports`到`.run`安装包

=== 使用`.run`文件与DKMS及开源内核模块进行安装

=== `nvidia-persistenced`服务的手动配置

=== CUDA Toolkit与cuDNN的安装

== Slurm一体化部署

=== Munge认证配置

=== 数据库(MariaDB)与`slurmdbd`记账配置

=== `slurm.conf`最终版详解 (单节点，多角色)

=== `gres.conf`与`cgroup.conf`的精确配置

=== QOS与分区的精细化权限管理


= 用户环境与软件栈

== 全局共享软件的安装 (`/opt`)

=== Docker, Redis (通过`apt`)

=== Rust, Node.js, Miniforge, uv (手动安装至`/opt`)

== 全局环境变量配置 (`/etc/profile.d`)

== 软件镜像源的统一配置

== 预装科学计算库与命令行工具集


= 用户会话的资源限制 (原生安全核心)

== PAM与cgroups v2的协同工作原理

=== 使用`systemd` Slice单元定义资源模板 (`/etc/systemd/system/user-.slice.d/`)

=== 限制CPU (`CPUQuota`, `CPUWeight`)

=== 限制内存 (`MemoryMax`)

=== 通过设备白名单禁止GPU访问 (`DevicePolicy`, `DeviceAllow`)

== 通过`/etc/fstab`限制进程可见性

=== `hidepid`挂载选项的原理与应用

=== 配置`/proc`的挂载，增强用户隔离

== 通过文件权限避免安全问题

=== 锁定`/opt`共享软件目录为只读

=== 其他关键目录的权限策略



// ========================================
// 部分页
// ========================================
#page(
  align(center)[
    #v(8cm)

    #text(size: 32pt, weight: "bold", font: "FZHei-B01S")[
      第三部分：集群的日常——运维管理实战 (管理员篇)
    ]
  ],
  header: none,
  footer: none,
)

= 用户与资源管理

== 用户生命周期管理

=== 创建新用户 (`add_user.py`脚本)

=== 删除用户 (`del_user.py`脚本)

== Slurm账户与QOS管理 (`sacctmgr`)

== 磁盘配额管理 (`edquota`, `repquota`)


= 日常维护与监控

== 日常/周常/月常维护清单

== 监控面板部署与使用 (Prometheus + Grafana on Docker)

== 备份与灾难恢复策略 (Clonezilla)


= 外部服务集成与管理

== EasyTier VPN配置与维护

=== 服务器端配置

=== 如何为新用户安全地分发密钥

== 独立NAS系统管理

=== NAS的定位与使用哲学

=== 在NAS上创建用户账户的指导

=== NAS的数据备份与快照功能


= 故障排查指南 (Troubleshooting)

== Slurm常见问题排查

== NVIDIA驱动问题排查

== 用户权限问题诊断


// ========================================
// 部分页
// ========================================
#page(
  align(center)[
    #v(8cm)

    #text(size: 32pt, weight: "bold", font: "FZHei-B01S")[
      第四部分：开始计算！——科研平台使用指南 (用户篇)
    ]
  ],
  header: none,
  footer: none,
)

= 远程访问

== 通过EasyTier VPN连接到实验室网络

== 使用VS Code Remote-SSH连接到`rs1`


= 核心工作流

== 文件管理与Git集成

== 理解您的“双重世界”：受限的登录会话 vs. Slurm作业

== 环境管理 (`uv` & `conda`)

== 提交与管理您的Slurm作业


= 数据存储与协作

== 使用您的`/home`目录 (高速，有配额)

== 连接和使用实验室NAS

=== 如何在您的个人电脑上挂载NAS共享

=== NAS的使用规范与数据归档建议




= 附录

== 服务器预装软件与工具清单

== 常用命令参考

常用Linux和Slurm命令的快速参考...

== 联系方式

管理员联系信息和技术支持渠道...
