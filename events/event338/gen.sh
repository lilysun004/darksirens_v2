lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.446086086086087 --fixed-mass2 80.78118118118118 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1031042087.6159002 \
--gps-end-time 1031049287.6159002 \
--d-distr volume \
--min-distance 2236.108469348587e3 --max-distance 2236.1284693485873e3 \
--l-distr fixed --longitude 106.34481811523438 --latitude 8.232637405395508 --i-distr uniform \
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
