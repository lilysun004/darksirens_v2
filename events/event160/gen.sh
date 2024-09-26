lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 2.7042642642642645 --fixed-mass2 38.170850850850854 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004945236.5197402 \
--gps-end-time 1004952436.5197402 \
--d-distr volume \
--min-distance 247.91251143753598e3 --max-distance 247.93251143753596e3 \
--l-distr fixed --longitude -148.18130493164062 --latitude 37.64537048339844 --i-distr uniform \
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
