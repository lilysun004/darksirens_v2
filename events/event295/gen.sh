lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 40.60812812812813 --fixed-mass2 22.958878878878878 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027194869.9975083 \
--gps-end-time 1027202069.9975083 \
--d-distr volume \
--min-distance 2842.4023851734887e3 --max-distance 2842.422385173489e3 \
--l-distr fixed --longitude 11.733050346374512 --latitude -80.80567169189453 --i-distr uniform \
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
