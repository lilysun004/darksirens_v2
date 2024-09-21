lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 64.64472472472472 --fixed-mass2 64.47663663663664 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024154510.5270298 \
--gps-end-time 1024161710.5270298 \
--d-distr volume \
--min-distance 2780.9949377064986e3 --max-distance 2781.014937706499e3 \
--l-distr fixed --longitude -78.20480346679688 --latitude 42.95259094238281 --i-distr uniform \
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
