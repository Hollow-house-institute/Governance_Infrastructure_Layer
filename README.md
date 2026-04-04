# Governance Infrastructure Layer

A real-time system that converts behavioral drift into enforceable control decisions.

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

## Quick Start

```bash
npm install
node index.js
