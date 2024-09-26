lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 2.6202202202202205 --fixed-mass2 57.669069069069074 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014152977.7356243 \
--gps-end-time 1014160177.7356243 \
--d-distr volume \
--min-distance 400.7542035425441e3 --max-distance 400.77420354254406e3 \
--l-distr fixed --longitude -177.92445373535156 --latitude 0.10483517497777939 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
