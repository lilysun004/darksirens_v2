lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.496016016016018 --fixed-mass2 52.542382382382385 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029622865.0799842 \
--gps-end-time 1029630065.0799842 \
--d-distr volume \
--min-distance 1833.6007117572979e3 --max-distance 1833.6207117572978e3 \
--l-distr fixed --longitude -1.146148681640625 --latitude 3.581362009048462 --i-distr uniform \
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
