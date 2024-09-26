lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 65.7372972972973 --fixed-mass2 82.20992992992993 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015475763.1321821 \
--gps-end-time 1015482963.1321821 \
--d-distr volume \
--min-distance 1348.2521458144083e3 --max-distance 1348.2721458144083e3 \
--l-distr fixed --longitude -46.4453125 --latitude 54.416221618652344 --i-distr uniform \
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
