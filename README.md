# Linear Optimization in Wireless Communication (Interference / SINR) — MATLAB Example

An illustrative example is provided for modeling an interference-limited wireless uplink and reformulating **SINR (Signal-to-Interference Ratio)** constraints as a **linear optimization problem**.

A MATLAB script is included to construct the standard linear-program form:
\[
\min \; C^\top p \quad \text{s.t.}\quad A p \le b
\]
where \(p\) is the transmit-power vector and the SINR feasibility conditions are encoded inside \(A\) and \(b\).

---

## Repository Contents

- `Wireless_Communication_Linear_Optimization.m`  
  A MATLAB implementation in which the SINR constraints and the corresponding LP matrices are derived.

- `Screenshot_1.png`, `Screenshot_2.png`  
  Problem statement and intermediate formulation (as captured from notes/screens).

- `Screenshot_3.png`  
  Final checked formulation/solution snapshot.

---

## Problem Statement (Interference-Limited Uplink)

A system with **\(n\)** mobile users and one base station is considered.

For each user \(i \in \{1,\dots,n\}\):

- Transmit power is denoted by \(p_i\).
- Channel attenuation (gain) is denoted by \(h_i\).
- The received signal power for user \(i\) is \(h_i p_i\).
- When user \(i\) is being decoded, the received power from all other users is treated as interference:
  \[
  I_i = \sum_{j\ne i} h_j p_j
  \]
- Reliable communication is enforced by requiring the SINR to exceed a threshold \(\gamma_i\):
  \[
  \mathrm{SINR}_i = \frac{h_i p_i}{\sum_{j\ne i} h_j p_j} \ge \gamma_i
  \]

---

## SINR \(\rightarrow\) Linear Inequalities

Each SINR constraint is rearranged into a linear form:

\[
\frac{h_i p_i}{\sum_{j\ne i} h_j p_j} \ge \gamma_i
\quad\Longleftrightarrow\quad
h_i p_i \ge \gamma_i \sum_{j\ne i} h_j p_j
\]

\[
h_i p_i - \gamma_i \sum_{j\ne i} h_j p_j \ge 0
\]

To match the standard LP inequality direction \(A p \le b\), the equivalent form is commonly written as:

\[
-\,h_i p_i + \gamma_i \sum_{j\ne i} h_j p_j \le 0
\]

By stacking these inequalities for all users, the matrices \(A\) and \(b\) are obtained.

---

## MATLAB Implementation Notes

- Symbolic variables (`syms`) are used for derivations and matrix construction.
- `linprog` is intentionally not used, since the derivation is performed symbolically and the LP form is built “manually” for clarity and inspection.

---

## How the Script Is Used

### Input
- `n` is requested as an input at runtime (the number of users).

### Output
The following are produced/printed by the script:
- The **SINR expression** and its constraint form (how SINR is formulated).
- The standard LP components:
  - \(C^\top\) (objective coefficients, as defined in the script),
  - \(A\) (constraint matrix),
  - \(b\) (constraint vector).

---

## Screenshots (Embedded)

![Screenshot 1](Screenshot_1.png)
![Screenshot 2](Screenshot_2.png)
![Screenshot 3](Screenshot_3.png)

---

## Quick Start

1. MATLAB (with Symbolic Math Toolbox) is recommended.
2. The script is executed:
   - `Wireless_Communication_Linear_Optimization.m`
3. When prompted, `n` is entered.
4. The generated SINR formulation and the LP matrices \(C^\top, A, b\) are inspected in the MATLAB output.

---

## Notes

- The exact objective (i.e., how \(C^\top\) is defined) is controlled inside the MATLAB script and is expected to reflect the intended optimization target for the modeled system (e.g., a power-related criterion).
- Parameter values (e.g., \(h_i\), \(\gamma_i\)) are expected to be defined/edited inside the script according to the desired scenario.

---
