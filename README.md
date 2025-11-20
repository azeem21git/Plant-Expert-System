# Plant-Expert-System

# Palant Expert System (Prolog)

A lightweight **expert system** implemented in Prolog that demonstrates rule-based reasoning, forward/backward chaining, and a small knowledge base for diagnosing simple problems (e.g., plant disease diagnosis, configuration help, or any domain you adapt it to).

> **Note:** This repository uses SWI‑Prolog for development and testing.

---

## 🎯 Project Summary

Palant is a small expert system written in Prolog. It contains:

* A modular knowledge base (facts and rules).
* An inference engine using Prolog's built-in resolution (can be adapted to explicit forward/backward chaining style).
* Example queries and a small interactive shell script to run sessions.

This project is ideal for learning how rule-based systems work and how to structure expert-system code in Prolog.

---

## 📁 Repository Structure

```
palant-prolog/
├─ README.md                 # This file
├─ src/
│  ├─ knowledge_base.pl      # Domain facts and rules
│  ├─ engine.pl              # Optional helper predicates / inference wrappers
│  └─ interface.pl           # CLI / interactive helpers
├─ examples/
│  └─ sample_queries.txt    # Example queries to try
├─ tests/
│  └─ test_palant.pl        # Unit tests (if any)
└─ assets/
   └─ flowchart.png         # (Optional) architecture / flowchart
```

> Flowchart / diagram (local file):
>
> `assets/flowchart.png` → `/mnt/data/A_flowchart_explains_how_Google_Maps_algorithms_wo.png`
>
> You can preview it in this repo using the file path: `/mnt/data/A_flowchart_explains_how_Google_Maps_algorithms_wo.png`

---

## 🛠️ Requirements

* SWI‑Prolog (recommended) — available at [https://www.swi-prolog.org/](https://www.swi-prolog.org/)
* Git (for cloning the repo)

---

## 🚀 Installation

1. Clone this repository:

```bash
git clone <your-repo-url> palant-prolog
cd palant-prolog
```

2. Start SWI‑Prolog:

```bash
swipl
```

3. Load the system (example):

```prolog
?- ["src/knowledge_base.pl"].
?- ["src/engine.pl"].
?- ["src/interface.pl"].
```

(Or create a bootstrap file `main.pl` that consults all sources.)

---

## ▶️ Quick Usage

Start an interactive Prolog session and run example queries.

Example session:

```prolog
?- consult('src/knowledge_base.pl').
?- consult('src/interface.pl').

%
```

