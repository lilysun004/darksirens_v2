lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.201241241241242 --fixed-mass2 36.40592592592593 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021747075.6413175 \
--gps-end-time 1021754275.6413175 \
--d-distr volume \
--min-distance 1332.1714681374758e3 --max-distance 1332.1914681374758e3 \
--l-distr fixed --longitude 113.77911376953125 --latitude 39.162391662597656 --i-distr uniform \
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
