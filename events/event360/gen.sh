lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.78226226226226 --fixed-mass2 66.66178178178178 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028268040.5616738 \
--gps-end-time 1028275240.5616738 \
--d-distr volume \
--min-distance 1414.4811268891212e3 --max-distance 1414.5011268891212e3 \
--l-distr fixed --longitude -120.134521484375 --latitude 38.37614822387695 --i-distr uniform \
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
