lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 9.848008008008009 --fixed-mass2 22.286526526526526 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000104741.2915838 \
--gps-end-time 1000111941.2915838 \
--d-distr volume \
--min-distance 1592.4101347802568e3 --max-distance 1592.4301347802568e3 \
--l-distr fixed --longitude -4.002197265625 --latitude 72.17829895019531 --i-distr uniform \
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
