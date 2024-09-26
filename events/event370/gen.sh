lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 30.774974974974974 --fixed-mass2 32.62394394394394 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005129511.9479932 \
--gps-end-time 1005136711.9479932 \
--d-distr volume \
--min-distance 2638.3476647513203e3 --max-distance 2638.3676647513207e3 \
--l-distr fixed --longitude 66.95528411865234 --latitude 71.43486785888672 --i-distr uniform \
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
