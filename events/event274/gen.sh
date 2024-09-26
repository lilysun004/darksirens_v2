lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.84072072072072 --fixed-mass2 75.06618618618619 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028533217.920771 \
--gps-end-time 1028540417.920771 \
--d-distr volume \
--min-distance 1248.9241784632718e3 --max-distance 1248.9441784632718e3 \
--l-distr fixed --longitude 38.69902801513672 --latitude 37.47587585449219 --i-distr uniform \
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
