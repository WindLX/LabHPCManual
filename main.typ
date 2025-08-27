#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

#codly(
  languages: (
    rust: (name: "Rust", icon: "🦀", color: rgb("#CE412B")),
  ),
)

// 文档基本设置，例如设置语言为中文，启用智能标点转换
#set text(lang: "zh")
#set smartquote(enabled: true)

// 文档引言
为了帮助您快速、高效地利用我们强大的计算资源，请仔细阅读本手册。本平台旨在为您提供稳定、公平的计算环境，以加速您的科研进程。

// = 是一级标题
= 一、初次见面 - 连接到服务器

我们的计算平台由两台核心服务器组成，但您*只需要与其中一台即登录节点交互*：

// - 是无序列表
- `ipc` (IP: `192.168.5.45:4000`，当你在实验室外时使用这个 IP `202.121.179.242:54000`): *登录节点*。这是我们集群的*唯一入口*。所有代码编辑、环境配置、任务提交都在这里进行。
- `rs1` (IP: `192.168.5.36`): *计算节点*。它拥有强大的GPU，负责运行您提交的计算任务。您*不能*也*不需要*直接登录到这台机器。

// == 是二级标题
== 1.1 唯一推荐工具：Visual Studio Code

我们强烈推荐使用 *VS Code* 及其 *Remote - SSH* 扩展作为您与服务器交互的唯一图形化工具。它能为您提供“在本地编码，在服务器运行”的无缝体验。

// + 是有序列表，Typst会自动编号
+ 在您的个人电脑上，下载并安装 #link("https://code.visualstudio.com/")[Visual Studio Code]。
+ 打开VS Code，在左侧的扩展商店中，搜索并安装 `"Remote - SSH"` 和 `"slurm--"` 扩展包。

== 1.2 您的账户信息

- *主机名/IP:* `ipc` 或 `192.168.5.45`，当你在实验室外时使用这个 IP `202.121.179.242:54000`，当你在校外请连接 SJTU VPN
- *用户名:* (管理员已为您创建，例如 `windlx`)
- *初始密码:* (管理员会私下告诉您)

== 1.3 连接到服务器并修改密码

+ 在VS Code中，按下`F1`或`Ctrl+Shift+P`打开命令面板。
+ 输入`Remote-SSH: Connect to Host...`并选择它。
+ 选择`+ Add New SSH Host...`。
+ 输入连接命令：`ssh windlx@ipc` (或使用IP地址)。
+ 选择默认的SSH配置文件进行保存。
+ 再次按下`F1`，选择`Remote-SSH: Connect to Host...`，这次选择您刚刚创建的`ipc`。
+ 一个新的VS Code窗口会打开。在弹出的终端中，输入您的*初始密码*。
+ 连接成功后，*第一件事就是在VS Code的终端里修改为您自己的强密码*：

// ```` 用于代码块
```rust
passwd
```

系统会提示您输入当前密码，然后输入两次新密码。

// #line 创建一条水平线
#line(length: 100%)

= 二、代码与数据 - 文件管理

连接成功后，VS Code就成为了您的“远程驾驶舱”。

== 2.1 使用VS Code的文件浏览器

- 点击VS Code左上角的文件图标，选择“打开文件夹”。
- 在弹出的路径中，直接输入您的家目录路径，例如`/home/windlx`，然后按确定。
- 现在，VS Code左侧的文件浏览器会实时显示您服务器上的文件。您可以像操作本地文件一样，*直接拖拽文件*从您的电脑到VS Code的文件浏览器中进行*上传*，或者从VS Code中拖到本地进行*下载*。

== 2.2 使用Git (在VS Code终端中)

这是同步代码的*最佳方式*。您需要在服务器上配置一次SSH密钥，以便免密访问您的代码托管平台（如GitHub）。

+ *在VS Code的集成终端中* (通过菜单`终端` -> `新建终端`打开)，运行`ssh-keygen -t ed25519`生成密钥。
+ 运行`cat ~/.ssh/id_ed25519.pub`查看并复制您的公钥。
+ 将公钥粘贴到您的GitHub/Gitee等代码平台的“SSH Keys”设置中。
+ 现在，您可以自由地使用Git了：

````bash
# 克隆您的项目
git clone git@github.com:your-name/my-project.git

# VS Code的源代码管理(Source Control)侧边栏也会自动识别Git仓库，
# 您可以通过图形化界面进行commit和push操作。
````

#line(length: 100%)

= 三、配置您的“工作室” - 环境管理

所有环境管理操作，都在*VS Code的集成终端*中完成。

== 3.1 使用 `uv` (推荐)

`uv`是一个现代、极速的Python环境和包管理器。

````bash
# 1. 在VS Code中，打开您的项目文件夹。

# 2. 在VS Code的终端里，创建一个基于特定Python版本的虚拟环境
uv init hello-world

# 3. 激活环境：VS Code非常智能，它会自动检测到.venv目录。
#    按下 Ctrl+Shift+P，输入 "Python: Select Interpreter"，
#    然后选择带有 '(.venv)' 标签的解释器。
#    之后，所有新打开的终端都会自动激活这个环境。

# 4. 在已激活的终端里，安装您需要的包
uv add numpy
````

更多细节请参照 #link("https://uv.doczh.com/")[uv] 官网

== 3.2 使用 `conda`

````bash
# 1. 在VS Code终端里，克隆一个由管理员预置的基础环境
conda create --name my_project_env --clone py311

# 2. 激活环境：与uv类似，使用 "Python: Select Interpreter" 命令，
#    选择位于 anaconda/envs/ 目录下的新环境解释器。
````

#line(length: 100%)

= 四、开始计算！- 提交任务到Slurm

所有与Slurm的交互，都在*VS Code的集成终端*中完成。

+ #link("https://scc.ustc.edu.cn/hmli/doc/linux/slurm-install/index.html")[ustc slurm 文档]
+ #link("https://docs.hpc.sjtu.edu.cn/job/slurm.html")[sjtu slurm 文档]
+ #link("https://doc.slurm.cn/")[slurm zh-cn]

== 4.1 核心理念：编写“作业脚本”

您可以使用VS Code强大的编辑器，来编写一个`bash`脚本（例如`run_exp1.slurm`），在脚本里告诉Slurm您需要多少资源，以及要运行什么命令。

== 4.2 作业脚本模板

- 在VS Code中新建一个`run_exp1.slurm`文件，将之前的模板内容粘贴进去，并根据您的需求修改。
- 利用VS Code的语法高亮和编辑功能，编写和修改会非常舒适。

这里有一个示例，更多信息请参见 slurm 文档。

````bash
#!/bin/bash

# --- SBATCH 指令 ---
#SBATCH --job-name=torch_check        # 任务名
#SBATCH --output=torch_check_%j.out   # 输出日志
#SBATCH --error=torch_check_%j.err    # 错误日志

# -- 资源申请 --
# 我们使用compute分区，因为它响应快，且这个任务很短
#SBATCH --partition=compute
# 申请1个GPU来进行测试
#SBATCH --gres=gpu:1
# 申请少量CPU和内存即可
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G

# --- 您的命令 ---

echo "===================================================="
echo "Slurm Job started on: $(date)"
echo "Running on node: $(hostname)"
echo "Job ID: $SLURM_JOB_ID"
echo "===================================================="

# 1. 激活您的Python虚拟环境
#    请根据您自己的环境类型和名称，取消注释并修改下面的一行
#
#    对于uv:
#    source ~/path/to/your/project/.venv/bin/activate
#
#    对于conda:
#    source /opt/min_iforge3/bin/activate
#    conda activate your_env_name

# 【请在这里替换成您自己的环境激活命令！】
source /home/windlx/test_torch/.venv/bin/activate

# 检查Python和pip的位置，确保环境已激活
echo "Using Python: $(which python)"
echo "Using pip: $(which pip)"
echo "----------------------------------------------------"


# 2. 运行Python验证脚本
#    -u 参数可以确保Python的输出是无缓冲的，会实时写入日志文件
python -u main.py

echo "===================================================="
echo "Slurm Job finished at: $(date)"
echo "===================================================="
````

== 4.3 提交与管理任务

所有Slurm命令都在VS Code的终端里运行。

- *提交作业：*
  ````bash
  sbatch run_exp1.slurm
  ````
- *查看队列：*
  ````bash
  squeue -u $USER
  ````
- *取消任务：*
  ````bash
  scancel <jobid>
  ````

#line(length: 100%)

= 附录A：服务器预装软件与工具清单

为了方便您的工作，我们已经在服务器上预装并配置了一系列强大、高效的开发工具和基础库。这些工具对所有用户全局可用，您无需自行安装。

// === 是三级标题
=== A.1 核心语言与工具链

您可以通过`/etc/profile.d/`下的全局配置，直接在终端中使用以下命令：

- *Python (通过 `conda` 和 `uv`)*
  // 列表可以嵌套
  - *Conda (Miniforge):* 我们提供了一个基于`conda-forge`频道的最小化Conda环境。您可以使用`conda`命令来管理独立的环境。
    - *命令:* `conda`, `python` (基础环境)
    - *已预置基础环境:* `py310`, `py311`, `py312`等，您可以通过`conda create --clone`来快速创建自己的环境。
  - *uv:* 一个极速的Python包和环境管理器，作为`pip`和`venv`的替代品。
    - *命令:* `uv`
    - *已预装Python解释器:* `uv`可以为您自动下载并管理多个Python版本，您可以通过`uv python list`查看。

- *Rust*
  - 我们提供了完整的Rust开发工具链。
  - *命令:* `rustc` (编译器), `cargo` (包管理器与构建工具), `rustup` (工具链管理器)。

=== A.2 服务

- *Docker:* 业界标准的容器化引擎。
  - *命令:* `docker`, `docker compose`。
  - *权限:* 您需要联系管理员，将您的账户加入`docker`用户组，才能免`sudo`使用。
  - *用途:* 用于构建可复现的复杂环境、运行特定的服务或打包您的应用。

- *Redis:* 高性能的内存数据库。
  - *命令:* `redis-cli` (客户端)。
  - *用途:* 可用于实验中的缓存、消息队列等。服务已在后台运行。

=== A.3 命令行“瑞士军刀” (提升效率)

我们预装了一系列现代化的命令行工具，以替代传统的Linux命令，极大提升您的工作幸福感。

- *终端会话管理 (网络断开也不怕):*
  - `tmux`: 经典、功能强大的终端复用器。
  - `zellij`: 现代、对用户更友好的终端复用器，自带布局和状态栏。

- *文件搜索与查看：*
  - `rg` (`ripgrep`): `grep`的极速替代品，自动忽略`.gitignore`。
  - `fd`: `find`的现代化、人性化替代品。
  - `fzf`: 模糊搜索神器，可以配合任何命令使用 (`Ctrl+R`搜索历史, `Ctrl+T`搜索文件)。
  - `bat`: `cat`的替代品，自带语法高亮、行号和Git集成。

- *文件与目录管理：*
  - `yazi`: 强大的终端文件管理器，供您选择。
  - `zoxide`: `cd`的智能替代品。它会学习您常去的目录，用`z <目录名片段>`即可快速跳转。
  - `dust` / `duf`: 比`du`和`df`更美观、更直观的磁盘/目录空间分析工具。

- *文本与其他：*
  - `jq`: 命令行JSON处理器，处理API返回或配置文件必备。
  - `sd`: `sed`的简化、直观替代品，用于流式文本替换。

=== A.4 核心开发库 (C/C++/Fortran)

对于需要编译代码或安装某些复杂Python包的用户，我们在系统中全局安装了以下核心科学计算与开发库。您无需关心它们，包的安装过程会自动找到它们。

- *构建系统:* `cmake`, `ninja`
- *线性代数:* `Eigen3`, `OpenBLAS`, `LAPACK` (这些是NumPy/PyTorch/TensorFlow的底层性能基石)
- *并行计算:* `OpenMP`, `OpenMPI`
- *其他:* `Boost`, `HDF5`, `OpenCV`等常用库。

#line(length: 100%)

如有任何问题，请随时联系管理员。
