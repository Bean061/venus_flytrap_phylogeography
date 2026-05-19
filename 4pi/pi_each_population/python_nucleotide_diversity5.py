from Bio import AlignIO
from itertools import combinations
import sys

# IUPAC code to set of bases
iupac = {
    "A": {"A"}, "C": {"C"}, "G": {"G"}, "T": {"T"},
    "R": {"A", "G"}, "Y": {"C", "T"}, "S": {"G", "C"}, "W": {"A", "T"},
    "K": {"G", "T"}, "M": {"A", "C"}, "B": {"C", "G", "T"},
    "D": {"A", "G", "T"}, "H": {"A", "C", "T"}, "V": {"A", "C", "G"},
    "N": set(), "-": set()
}

def base_difference(b1, b2):
    s1 = iupac.get(b1.upper(), set())
    s2 = iupac.get(b2.upper(), set())
    if not s1 or not s2:
        return None  # missing data
    return 0 if s1 & s2 else 1  # 0 if overlapping, else 1

def calculate_pi_with_degenerate(filename, format="fasta"):
    alignment = AlignIO.read(filename, format)
    n = len(alignment)
    L = alignment.get_alignment_length()
    total_differences = 0
    valid_sites = 0

    for i in range(L):
        site = [record.seq[i] for record in alignment]
        diffs = []
        for a1, a2 in combinations(site, 2):
            diff = base_difference(a1, a2)
            if diff is not None:
                diffs.append(diff)
        if diffs:
            total_differences += sum(diffs)
            valid_sites += 1

    num_pairs = n * (n - 1) / 2
    if valid_sites == 0 or num_pairs == 0:
        return 0.0
    pi = (n / (n - 1)) *(total_differences / (num_pairs * valid_sites))
    return pi

# input fasta file
if __name__ == "__main__":
    filename = sys.argv[1]
    pi = calculate_pi_with_degenerate(filename)
    print(f"Nucleotide diversity (π) with degenerate bases: {pi:.6f}")
