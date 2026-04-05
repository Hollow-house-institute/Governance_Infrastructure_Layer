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
