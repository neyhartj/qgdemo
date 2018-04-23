# Theory


Below are explanations of the assumptions and theory that underlie the simulations in each of the tabs.

### Randomly mating populations

This simulation tracks the frequency of the $A$ allele over generations in one or more populations of randomly mating, diploid individuals. The simulation initiates with a starting allele frequency of $p_A$. Since the individuals are randomly mating, the number of $A$ alleles in each individual can be interpreted as $N$ (number of individuals) independent "experiments" where a "success" is possessing an $A$ allele. Realizations of the number of $A$ alleles in each individual are drawn from a bionomial distribution of size $N$ and success probability $p_A$, or $x_{0i} \sim \textrm{binom}(N, p_{A0})$, where $g = 0$ indicates the generation number ($0$ for the base generation) and $i$ indicates the individual number.

The mean of this realization is the average number of $A$ alleles in an individual. This estimate, divided by the number of alleles in an individual (2 for a diploid) gives the estimated frequency of $A$ alleles, or $\hat{p}_{A0} = \frac{1}{2} \sum{x_{0i}}$.

We assume that each individual is equally likely to pass alleles on to the next generation. Therefore, the realization of the number of $A$ alleles in the next generation is drawn from a similar binomial distribution, except the success probability is changed to the estimated allele frequency ($\hat{p}_A$) in the previous generation, or $x_{gi} \sim \textrm{binom}(N, \hat{p}_A)$. This process is repeated for $g = 1, 2, ..., G$ generations.

The whole simulation can be re-written as follows:

1. Set the starting frequency of $A$ alleles, or $p_{A0}$
2. Sample realizations of the number of $A$ alleles, or $x_{0i} \sim \textrm{binom}(N, p_{A0})$
3. Estimate the frequency of $A$ alleles from the sample, or $\hat{p}_{A0} = \frac{1}{2} \sum{x_{0i}}$
4. For $g = 1, 2, ..., G$ generations:
    + Sample realizations of the number of $A$ alleles using the estimated allele frequency in the previous generation, or $x_{gi} \sim \textrm{binom}(N, \hat{p}_{A(g-1)})$
    + Estimate the frequency of $A$ alleles from the sample, or $\hat{p}_{Ag} = \frac{1}{2} \sum{x_{gi}}$


### Genetic variance


### Response to selection


