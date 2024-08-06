lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 4.217057057057057 --fixed-mass2 10.94058058058058 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026058065.2657794 \
--gps-end-time 1026065265.2657794 \
--d-distr volume \
--min-distance 603.3949779231187e3 --max-distance 603.4149779231187e3 \
--l-distr fixed --longitude 27.833208084106445 --latitude 0.4546784460544586 --i-distr uniform \
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
