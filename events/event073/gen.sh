lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 2.6202202202202205 --fixed-mass2 23.88336336336336 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024127899.7377186 \
--gps-end-time 1024135099.7377186 \
--d-distr volume \
--min-distance 494.64522716528535e3 --max-distance 494.66522716528533e3 \
--l-distr fixed --longitude 144.8916778564453 --latitude -84.57105255126953 --i-distr uniform \
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
