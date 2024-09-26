lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.285285285285287 --fixed-mass2 66.07347347347347 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024930249.2089889 \
--gps-end-time 1024937449.2089889 \
--d-distr volume \
--min-distance 1444.2976770253142e3 --max-distance 1444.3176770253142e3 \
--l-distr fixed --longitude -104.42843627929688 --latitude -51.681358337402344 --i-distr uniform \
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
