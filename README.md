# MATLAB ODE Solver Laboratory

This repository contains a MATLAB toolkit for solving ODEs. It provides a unified interface to over a dozen classical numerical methods, making it easy to run simulations, compare solver performance, and analyze accuracy when numerically solving both suggested and custom problems. It is designed to be modular so that new methods and problems can be easily added.

## How to use

1.  Clone or download this repository.
2.  Open MATLAB and navigate to the repository's root directory.
3.  You can now use the `ode_simulator` function directly from the MATLAB command window and your own scripts.

## Modes of Operation

1.  **`'method'`**: Solves an ODE with a single specified method.
2.  **`'compare'`**: Solves an ODE with multiple methods and plots their solutions together. The methods should be provided in a cell array.
3.  **`'analyze'`**: Solves an ODE with a single method and computes the error against a reference solution (either an exact solution if available, or MATLAB's `ode45` otherwise).

## Usage Examples

```
% Example 1: Run a single method
results = ode_simulator('method', 'rk4', 'problem', 'oscillator', 'N', 1000);

% Example 2: Compare multiple methods
results = ode_simulator('compare', {'euler', 'rk4', 'ab4'}, ...
                       'problem', 'lorenz', 'interval', [0, 10]);

% Example 3: Analyze method accuracy
results = ode_simulator('analyze', 'euler', 'problem', 'exponential', ...
                       'N', 100, 'verbose', true);

% Example 4: Custom problem
custom_f = @(t,x) [x(2), -sin(x(1))];  % Nonlinear pendulum
results = ode_simulator('method', 'rk4', 'problem', 'custom', ...
                       'f', custom_f, 'interval', [0, 10], 'x0', [pi/4, 0]);

% Example 5: Performance comparison
results = ode_simulator('compare', {'ab2am2', 'ab3am3', 'ab4am4'}, ...
                       'problem', 'van_der_pol', 'verbose', true);
```

## Available Components

### Implemented Numerical Methods

-   **Euler Methods:** `euler`, `eulermej`, `eulermod`
-   **Runge-Kutta Methods:** `rk3`, `rk4`
-   **Adams-Bashforth (Explicit):** `ab2`, `ab3`, `ab4`, `ab5`
-   **Adams-Bashforth-Moulton (Predictor-Corrector):** `ab2am2`, `ab3am3`, `ab4am4`
-   **Other:** `puntomedio`, `milne4`, `mmilne4bdf5`

### Predefined Problems

-   `'sine_product'` (1D)
-   `'harmonic_oscillator'` (2D)
-   `'forced_oscillator_2d'` (2D)
-   `'lorenz'` (3D Chaotic)
-   `'lorenz_high_r'` (3D)
-   `'lorenz_low_r'` (3D)
-   `'damped_spiral_exact'` (2D with exact solution)
-   `'forced_oscillator_exact'` (2D with exact solution)
-   `'pendulum_damped_forced'` (2D Non-linear)
-   `'pendulum_small_angle'` (2D Linearized)
-   `'lotka_volterra'` (2D Predator-Prey)
-   `'lotka_volterra_capacity'` (2D Predator-Prey with Capacity)
-   `'van_der_pol'` (2D)
-   `'van_der_pol_stiff'` (2D Stiff version)
-   `'duffing'` (2D Duffing Equation)
-   `'forced_harmonic'` (2D Forced Harmonic Oscillator)

## Structure

```
├── ode_simulator.m # Main API function
├── get_problem_params.m # Library of predefined ODE problems
├── get_method_function.m # Maps method names to function handles
├── plot_results.m # Handles plotting logic
├── methods/ # Folder for all solver implementations
│ ├── meuler.m
│ ├── mrk4.m
│ └── ...
└── README.md
```

## Author
This project was created by **Rodrigo Casado Noguerales** (as part of the 4th year course Numerical Methods of the Double BSc in Mathematics and Physics at Complutense University of Madrid).
