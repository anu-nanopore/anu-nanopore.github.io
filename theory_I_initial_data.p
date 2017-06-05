<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-Style-Type" content="text/css" />
  <meta name="generator" content="pandoc" />
  <title>MinION workshop - Getting to know your data</title>
  <style type="text/css">code{white-space: pre;}</style>
</head>
<body>
<div id="header">
<h1 class="title">MinION workshop - Getting to know your data</h1>
</div>
<p>pandoc brachy.md –smart –standalone –bibliography test.bib -o brachy.pdf</p>
<h2 id="section-goals">Section Goals</h2>
<ul>
<li>Understand the initial data that is coming from your MinION run</li>
<li>What is contained within the <code>fast5</code> datafiles</li>
<li>What we can, and cannot, do with the data at this point</li>
</ul>
<h2 id="general-pipeline-so-far">General pipeline so far:</h2>
<p><img of pores to voltage trace to computer></p>
<ul>
<li>The MinKNOW software on the sequencing laptop facilitates the collection and parsing of data from the MinION flowcell.</li>
<li>This ‘raw’ data is voltage traces that are measured at 5khz (5 thousands times per second).</li>
<li>The voltage across the membrane changes as molecules enter, move through, and exit each sequencing pore.</li>
<li>This entire measurement is called an ‘event’ which will be the collected signal measurements for that molecule.</li>
<li>The software recognizes this initial voltage change and begins writing out the trace to a new <code>fast5</code> file.</li>
<li>There is <strong>one file per DNA molecule</strong> that passes through each pore. Therefore many files are created!</li>
<li>Hence, the requirement for high quality transfer speeds on your laptop to facilitate this (SSDs)</li>
<li>This is a fundamental shift from Illumina platforms in which most analysis is based off of fewer, but much larger, files.</li>
</ul>
<h2 id="the-initial-data-is-not-basecalled">The initial data is NOT basecalled</h2>
<ul>
<li>At this point, we do not have nucleotide information, just voltage traces.</li>
<li>We can look at this information within the fast5 files that are created.</li>
</ul>
<h2 id="what-are-fast5-files">What are <code>fast5</code> files?</h2>
<ul>
<li>Each file contains signal trace for a single DNA molecule</li>
<li><code>fast5</code> files are stored in the <code>HDF5</code> file format.</li>
<li><code>HDF5</code> acts as a larger organizational framework (box) in which different types of data can be stored in a hierarchical way.</li>
<li><p>Like directories, sub-directories, and files/data on your computer.</p></li>
<li><p>The <code>HDF5</code> format is quite flexable in being able to contain a wide variety of data types internally (strings,int,float,arrays, etc) within the single ‘HDF5’ format.</p></li>
<li><p>The <code>fast5</code> files are therefore able to not only hold the signal trace, but also a wide variety of metadata related to how it was created, timestamps, software versions, etc.</p></li>
<li>The format allows for new items to be added to it over time, creating a single container from raw information onwards</li>
<li><p>We will see this shortly.</p></li>
<li><p>We can investigate any <code>fast5</code> file using an <code>HDF5</code> ‘viewer’ which will show the internal structure and datasets in an easy-to-examine GUI.</p></li>
<li>The group that created the <code>HDF5</code> format <a href="https://support.hdfgroup.org/products/java/release/download.html">provides a java-based viewing software to download:</a></li>
<li><a href="ftp://130.56.254.90/pub/HDF5View_local_download/HDFView-2.13-win64.zip">HDFView for windows</a></li>
<li><a href="ftp://130.56.254.90/pub/HDF5View_local_download/HDFView-2.13.dmg">HDFView for OSX</a></li>
<li><p><a href="ftp://130.56.254.90/pub/HDF5View_local_download/HDFView-2.13.0-centos6-x64.tar.gz">HDFView for Linux</a></p></li>
<li><p>There are also <a href="https://support.hdfgroup.org/HDF5/Tutor/cmdtoolview.html">command-line tools to viewing HDF5 files for those interested</a></p></li>
</ul>
<h2 id="where-are-the-fast5-files-located">Where are the <code>fast5</code> files located?</h2>
<ul>
<li>As sequencing begins, data beings to be filled in to the <code>./reads</code> directory within your MinKNOW install folder:</li>
</ul>
<p>As of MinKNOW v1.6.11:</p>
<p>Windows: OSX: <code>/Library/MinKNOW/data/reads/</code> Linux:</p>
<h2 id="lets-take-a-look-at-a-fast5-file">Let’s take a look at a <code>fast5</code> file</h2>
<div class="figure">
<img src="./images/hdf5view_1.png" alt="screenshot from hdfview" />
<p class="caption">screenshot from hdfview</p>
</div>
<h2 id="additional-notes">Additional Notes</h2>
<ul>
<li><p>Remember that everything is rapidly-changing! What you learn now will likely be redundant and/or wrong with the MinION practices six months from now.</p></li>
<li><p>ONP wants to move towards elimination of <code>fast5</code> files and have MinKNOW basecall directly to fastq files (you never seen these steps)</p></li>
<li><p>This is largely useful information for those interested in the deep technical information of MinION tech as well as those interested in working directly with sequence traces (new basecalling methods, etc)</p></li>
</ul>
</body>
</html>
