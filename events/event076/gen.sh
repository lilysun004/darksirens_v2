lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.387627627627626 --fixed-mass2 74.8980980980981 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011547582.3249104 \
--gps-end-time 1011554782.3249104 \
--d-distr volume \
--min-distance 3305.465344109996e3 --max-distance 3305.4853441099963e3 \
--l-distr fixed --longitude 174.94146728515625 --latitude -60.296775817871094 --i-distr uniform \
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
