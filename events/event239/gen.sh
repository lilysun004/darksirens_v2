lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 2.284044044044044 --fixed-mass2 22.034394394394393 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023954443.1540213 \
--gps-end-time 1023961643.1540213 \
--d-distr volume \
--min-distance 941.5113980489895e3 --max-distance 941.5313980489894e3 \
--l-distr fixed --longitude 158.37478637695312 --latitude -51.86928176879883 --i-distr uniform \
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
