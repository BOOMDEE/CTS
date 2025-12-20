# Windows RDP Server via GitHub Actions

## Table of Contents
- [中文说明（Chinese）](#中文说明-chinese)
- [English Documentation](#english-documentation)

---

## 中文说明（Chinese）

### 项目存在的意义

本项目用于探索 **GitHub Actions 上的 Windows Runner 在真实系统场景中的行为边界**。

它并非将 GitHub Actions 作为长期服务器使用，而是通过工程化拆分的方式，研究以下问题：

- 短生命周期 Windows 环境的可配置能力  
- CI 平台与交互式使用之间的设计差异  
- 远程访问技术在临时基础设施中的可行性  
- 平台能力与平台策略之间的边界

这是一个**技术实验项目**，而非生产级部署方案。

---

### 整体架构设计

整个 workflow 被拆分为多个独立模块，每个模块只负责一件事：

1. Windows 环境初始化  
2. RDP 功能配置  
3. 本地用户创建  
4. 安全网络连接建立  
5. 可访问性验证  

这种设计有利于：
- 精确观察每一步的系统行为  
- 单独替换或调整某个模块  
- 避免隐式假设带来的不确定性  

---

### 为什么选择 GitHub Actions

选择 GitHub Actions 的原因包括：

- 提供干净、可复现的 Windows 环境  
- 启动速度快，适合短周期实验  
- Runner 完全隔离，便于观察系统初始化过程  
- 执行模型清晰，行为可预测  

它非常适合用于**理解平台能力，而不是长期运行服务**。

---

### RDP 模块的设计原因

RDP 是 Windows 原生的远程桌面协议，选择它是因为：

- 无需额外桌面环境  
- 符合真实 Windows 使用场景  
- 行为稳定、调试成本低  

该模块仅负责启用与验证 RDP 功能，不涉及绕过系统安全机制。

---

### 本地用户创建的意义

创建独立的本地用户有以下目的：

- 避免直接使用系统默认账户  
- 明确权限边界  
- 将远程访问与系统初始化逻辑隔离  

这是标准的系统管理实践。

---

### 为什么使用 Tailscale

项目**刻意避免**将 RDP 直接暴露在公网。

选择 Tailscale 的原因：

- 点对点加密通信  
- 无需开放入站防火墙端口  
- 适合 NAT / 受限网络环境  
- 将“网络信任”交由网络层处理  

换句话说：  
**安全性不依赖 RDP 本身，而由网络架构保证。**

---

### 验证步骤的意义

验证阶段用于确认：

- RDP 服务是否正常运行  
- 网络连接是否建立  
- 系统是否处于可交互状态  

该步骤提供确定性反馈，而不是假设系统已准备就绪。

---

### 设计理念

本项目遵循以下原则：

1. 模块化优先  
2. 显式优于隐式  
3. 观察优于滥用自动化  

每一个步骤的存在，都是为了让系统行为更可理解。

---

### 项目范围说明

本项目**不用于**：

- 提供持久远程桌面服务  
- 替代云服务器  
- 绕过平台限制  

其价值在于**理解与学习**。

---

## English Documentation

### Project Purpose

This project explores the **behavioral boundaries of Windows runners provided by GitHub Actions**.

Rather than acting as a persistent server, the workflow is designed to study:

- the configurability of short-lived Windows environments,
- the contrast between CI-oriented platforms and interactive use,
- the interaction between remote access technologies and ephemeral infrastructure,
- and the practical limits imposed by platform policies.

This is an **engineering experiment**, not a production system.

---

### Architectural Overview

The workflow is intentionally modular.  
Each step performs a single, explicit responsibility:

1. Windows initialization  
2. RDP configuration  
3. Local user creation  
4. Secure network setup  
5. Accessibility verification  

This structure enables clear observation and controlled experimentation.

---

### Why GitHub Actions

GitHub Actions offers:

- clean and reproducible Windows environments,
- fast startup times,
- strong isolation between runs,
- and a transparent execution model.

These characteristics make it ideal for platform-level experimentation.

---

### RDP Design Choice

RDP is selected because it is:

- native to Windows,
- realistic for desktop interaction,
- stable and well-understood.

The workflow enables RDP without weakening system security assumptions.

---

### Dedicated User Design

A separate local user is created to:

- avoid default system accounts,
- clearly define privilege boundaries,
- isolate access logic from system initialization.

This reflects real-world administrative best practices.

---

### Why Tailscale

Public RDP exposure is intentionally avoided.

Tailscale is used because it:

- provides encrypted peer-to-peer connectivity,
- avoids inbound firewall exposure,
- works reliably in restricted networks,
- separates network trust from desktop access.

Security is handled at the network layer, not by RDP alone.

---

### Verification Step

The verification phase confirms:

- RDP service availability,
- network connectivity,
- readiness for interaction.

This removes uncertainty from the workflow.

---

### Design Philosophy

The project follows three principles:

1. Modularity over monolithic design  
2. Explicit steps over implicit assumptions  
3. Observation over automation abuse  

Each component exists to clarify system behavior.

---

### Scope and Intent

This repository is intended for:

- technical exploration,
- platform behavior analysis,
- workflow architecture learning.

It is **not intended** to operate as a persistent remote desktop service.

---

### Final Note

The value of this project lies in understanding limitations.

Ephemeral systems reveal truths that permanent ones often conceal.
