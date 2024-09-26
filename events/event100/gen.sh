lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 41.112392392392394 --fixed-mass2 49.264664664664664 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012433934.2152995 \
--gps-end-time 1012441134.2152995 \
--d-distr volume \
--min-distance 4000.481587697161e3 --max-distance 4000.5015876971615e3 \
--l-distr fixed --longitude -147.0335693359375 --latitude -19.94941520690918 --i-distr uniform \
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
