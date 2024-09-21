lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.06726726726727 --fixed-mass2 7.242642642642643 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005477867.5037168 \
--gps-end-time 1005485067.5037168 \
--d-distr volume \
--min-distance 791.1279827324508e3 --max-distance 791.1479827324508e3 \
--l-distr fixed --longitude 121.47565460205078 --latitude 5.1137261390686035 --i-distr uniform \
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
