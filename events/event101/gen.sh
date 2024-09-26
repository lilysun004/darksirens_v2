lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.830950950950951 --fixed-mass2 46.57525525525526 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016381114.2515521 \
--gps-end-time 1016388314.2515521 \
--d-distr volume \
--min-distance 842.6758649220461e3 --max-distance 842.6958649220461e3 \
--l-distr fixed --longitude -32.944183349609375 --latitude 19.39605140686035 --i-distr uniform \
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
