![Node](https://img.shields.io/badge/node-%3E=18-green)
![Status](https://img.shields.io/badge/status-active-blue)
![Type](https://img.shields.io/badge/type-governance--engine-black)

# Governance Infrastructure Layer

> A system that decides whether execution should continue.

---

## What This Is

A real-time governance system that converts behavioral input into enforceable control decisions.

This is not monitoring.  
This is control.

---

## Example

**Input**
POST /drift  
{ "count": 3 }

**Output**
{
  "severity_label": "CRITICAL",
  "stop_authority": true
}

When drift crosses a threshold, the system can signal execution to stop.

## Live Demo

Run locally:

node index.js

Then:

curl -X POST http://localhost:3000/drift \
-H "Content-Type: application/json" \
-d '{"count":3}'
---

## How It Works

Behavior → Evaluation → Severity → Control Decision → Enforcement

---

## Quick Start

### Start the Engine

```bash
node index.js
```bash
npm install
node index.js
