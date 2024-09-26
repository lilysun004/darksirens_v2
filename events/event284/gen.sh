lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.46438438438439 --fixed-mass2 78.00772772772773 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023817373.1887124 \
--gps-end-time 1023824573.1887124 \
--d-distr volume \
--min-distance 2105.9174749166436e3 --max-distance 2105.937474916644e3 \
--l-distr fixed --longitude -49.238677978515625 --latitude -27.541545867919922 --i-distr uniform \
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
