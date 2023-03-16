# 2D and 3D depth sensor simulation in Matlab

This is a repository for simulating depth sensor measurements without the use of Matlab toolboxes

Examples for use include occupancy map updating or obstacle avoidance in a partially known map

## Installation

Clone repository using git clone https://github.com/UVA-BezzoRobotics-AMRLab/MatlabLidarSim.git

## Usage

* Running "2DUGVExample.m" will show a simulation of a 2D vehicle updating a partially known map as it moves through the environment using user-defined sensor parameters

* Running "constantYaw3DExample.m" will show a simulation of a 3D vehicle constantly yawing and moving through the environment. A partially known map is also updated but not pictorially displayed

Below is a picture of the 3D simulation in action:

<img src="images/3DexampleImage.png"
     alt="Markdown Monster icon"
     style="float: left; margin-right: 10px;" />

## Notes
If using this code, please consider citing:
Bramblett, Lauren, Shijie Gao, and Nicola Bezzo. "Epistemic Prediction and Planning with Implicit Coordination for Multi-Robot Teams in Communication Restricted Environments." arXiv preprint arXiv:2302.10393 (2023).

vol3d is a function written and copyrighted by Joe Conti, 2004