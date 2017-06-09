---
title: MinION workshop - What to do with basecalled data
authors: SRE
---

pandoc brachy.md --smart --standalone --bibliography test.bib -o brachy.pdf

# So we have some basecalled `fast5` files now! How did this change things?


## Lets look at a `fast5` file in `HDFView` to see what has changed

```
/{attributes: file_version}
|-UniqueGlobalKey/
| |-tracking_id/{attributes: standard tracking fields}
| |-channel_id/{attributes: channel_number, digitisation, offset, range, sampling_rate}
| |-context_tags/{attributes: set when the experiment is configured}
|-Raw/
| |-Reads/
| |-Read_42/{attributes: start_time, duration, read_number, start_mux, read_id}
| |-Signal{samples}
|-Analyses/
| |-Segmentation_000{attributes: name, version}
| | |-Configuration/
| | | |-stall_removal/{attributes: parameters for stall removal}
| | | |-split_hairpin/{attributes: parameters for hairpin splitting}
| | |-Summary/{attributes: return_status}
| | | |-segmentation/{attributes: has_template, has_complement, first_sample_template, duration_template, first_sample_complement, duration_complement, num_events_template, num_events_complement}
| |-Basecall_1D_000/{attributes: name, version}
| | |-Configuration/
| | | |-basecall_1d/{attributes: parameters for basecalling}
| | |-BaseCalled_template/
| | | |-Events{mean, stdv, start, length, model_state, move, weights, p_model_state, mp_state, p_mp_state, p_A, p_C, p_G, p_T}
| | | |-Fastq{string}
| | |-Summary/{attributes: return_status}
| | | |-basecall_1d_template/{attributes: num_events, called_events, mean_qscore, strand_score, sequence_length, stay_prob, step_prob, skip_prob}
|
```
## poretools

`poretools` is a toolkit for MinION data that can extract relevant data from `fast5` data into formats you know and love.

- [poretools github page](https://github.com/arq5x/poretools)
- [poretools publication in Bioinformatics](https://academic.oup.com/bioinformatics/article-lookup/doi/10.1093/bioinformatics/btu555)
- [poretools documentation](https://poretools.readthedocs.io/en/latest/)

poretools provides a simple command-line interface to examine your MinION basecalled data, determine overall quality, extract `fastq` or `fasta` sequences for downstream analysis, and more.

Let's examine how `poretools` acts in an analysis pipeline:

```
# get help on poretools in total:
poretools -h
```

### We can easily take a directory of basecalled fast5 files and create a `fastq` file:
```
poretools fastq ./path/to/fast5 > my.fastq
```

### Or a `fasta` file:
```
poretools fasta ./path/to/fast5 > my.fasta
```

From here, we have sequence data in formats that are more common to date and can be used with other analysis methods (to be discussed later today!)

### `poretools` can also provide information regarding your sequencing stats:
```
poretools stats ./path/to/fast5 stats
```

### plots of read size histogram:
```
poretools hist --theme-bw ./path/to/fast5
```
![hist from poretools docs](https://poretools.readthedocs.io/en/latest/_images/hist.png)

### examine the overall yield of reads over time
(remember, the fast5 files keep track of all sorts of metadata for these purposes!):
```
poretools yield_plot --plot-type reads ./path/to/fast5
```

![yield plot reads](https://poretools.readthedocs.io/en/latest/_images/yield.reads.png)

or by total basepairs:
```
poretools yield_plot --plot-type basepairs ./path/to/fast5
```

### look at the quality score distribution over read position:
```
poretools qpalpos ./path/to/fast5
```
![qualpos plot](https://poretools.readthedocs.io/en/latest/_images/qualpos.png)

### look at the overall performance of the pores on the flowcell (useful for finding positional / technical artifacts from sequencing)
```
poretools occupancy ./path/to/fast5
```
![occupancy plot](https://poretools.readthedocs.io/en/latest/_images/occupancy.png)

---
You can use `poretools` to examine the initial signal traces from a single fast5 file as well using `squiggle`

```
poretools squiggle ./path/to/single.fast5
```

### and most important, report the `winner` (longest read you got!)

```
poretools winner ./path/to/fast5
```
There are a few other commands and options for these to create slightly different plots of to pull additional metrics from your basecalled fast5 files. Take a bit of time to explore our training reads, as well as your first set of real data, today!
