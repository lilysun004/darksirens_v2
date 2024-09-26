lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.53741741741742 --fixed-mass2 21.950350350350348 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029189438.4814469 \
--gps-end-time 1029196638.4814469 \
--d-distr volume \
--min-distance 1565.5914470817395e3 --max-distance 1565.6114470817395e3 \
--l-distr fixed --longitude 171.68209838867188 --latitude 35.08036422729492 --i-distr uniform \
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
