lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.176896896896896 --fixed-mass2 75.90662662662663 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029485018.9258233 \
--gps-end-time 1029492218.9258233 \
--d-distr volume \
--min-distance 2795.9123611347595e3 --max-distance 2795.93236113476e3 \
--l-distr fixed --longitude 149.5469970703125 --latitude -28.036006927490234 --i-distr uniform \
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
